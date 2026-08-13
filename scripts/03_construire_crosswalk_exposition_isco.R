# Construit la table d'exposition IA par code ISCO-08, en fusionnant :
#   - Eloundou et al. (2024) : scores GPT (alpha/beta/gamma) au niveau O*NET-SOC
#   - Felten, Raj & Seamans (2021) : score AIOE au niveau SOC 6 chiffres
#   - Crosswalk IBS : SOC-10 <-> ISCO-08 (many-to-many)
#   - BLS OEWS (mai 2020, via 03a_extraire_poids_emploi_oews.R) : poids d'emploi
#     national US par code SOC-10, pour la moyenne ponderee des matches many-to-many
#
# Etape 4.2 du draft (paper/draft_v0.md) : Steps 1-2 (concordance directe + agregation
# many-to-many ponderee par l'emploi US). Quand un code SOC matche n'a pas de poids
# OEWS (SOC agrege/obsolete non couvert par le fichier "detailed"), on retombe sur
# une moyenne non ponderee pour ce code ISCO precis -- trace via n_soc_sans_poids.
#
# Donnees publiques uniquement (aucune micro-donnee d'enquete) -> lecture directe OK.

library(data.table)
library(haven)
library(readxl)

root <- "C:/Users/f.migone/Desktop/perso/ai_exposure_in_informal_developping_economies"
out_dir <- file.path(root, "data/processed")
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

# --- 1. Scores GPT (Eloundou et al. 2024), niveau O*NET-SOC ---
gpt <- fread(file.path(root, "data/raw/exposure_indices/eloundou_gpts_are_gpts/occ_level.csv"))
setnames(gpt, "O*NET-SOC Code", "onetsoc")

# Reduction O*NET-SOC (ex: "11-1011.03") -> SOC 6 chiffres numerique (ex: 111011)
gpt[, soc10 := as.numeric(gsub("-", "", substr(onetsoc, 1, 7)))]

gpt_soc <- gpt[, .(
  gpt_alpha = mean(dv_rating_alpha, na.rm = TRUE),
  gpt_beta  = mean(dv_rating_beta,  na.rm = TRUE),
  gpt_gamma = mean(dv_rating_gamma, na.rm = TRUE),
  n_onetsoc = .N
), by = soc10]

cat("GPT (Eloundou) agrege a", nrow(gpt_soc), "codes SOC-10\n")

# --- 2. Score AIOE (Felten, Raj & Seamans 2021), niveau SOC 6 chiffres ---
aioe <- as.data.table(read_excel(
  file.path(root, "data/raw/exposure_indices/felten_aioe/AIOE_DataAppendix.xlsx"),
  sheet = "Appendix A", skip = 0
))
setnames(aioe, c("soc_str", "title", "aioe"))
aioe <- aioe[!is.na(aioe) & grepl("^[0-9]{2}-[0-9]{4}$", soc_str)]
aioe[, soc10 := as.numeric(gsub("-", "", soc_str))]
aioe_soc <- aioe[, .(soc10, aioe)]

cat("AIOE (Felten et al.) :", nrow(aioe_soc), "codes SOC-10\n")

# --- 3. Crosswalk SOC-10 <-> ISCO-08 (IBS), many-to-many ---
cw_dir <- file.path(root, "data/raw/crosswalks/onetsoc_to_isco_ibs/onetsoc_to_isco_cws_ibs")
soc_isco <- as.data.table(read_dta(file.path(cw_dir, "soc10_isco08.dta")))

cat("Crosswalk SOC10->ISCO08 :", nrow(soc_isco), "paires,",
    uniqueN(soc_isco$soc10), "codes SOC uniques,",
    uniqueN(soc_isco$isco08), "codes ISCO-08 uniques\n")

# --- 3bis. Poids d'emploi national US par SOC-10 (BLS OEWS mai 2020, cf. 03a) ---
oews <- fread(file.path(root, "data/raw/exposure_indices/bls_oews/oews2020_national_soc_employment.csv"))
oews_w <- oews[, .(soc10, tot_emp)]

# --- 4. Fusion : SOC10 -> exposition, puis SOC10 -> ISCO08, puis poids d'emploi ---
exp_soc <- merge(gpt_soc, aioe_soc, by = "soc10", all = TRUE)

merged <- merge(soc_isco, exp_soc, by = "soc10", all.x = TRUE)
merged <- merge(merged, oews_w, by = "soc10", all.x = TRUE)

match_rate_gpt   <- merged[, mean(!is.na(gpt_alpha))]
match_rate_aioe  <- merged[, mean(!is.na(aioe))]
match_rate_union <- merged[, mean(!is.na(gpt_alpha) | !is.na(aioe))]
cat(sprintf("Taux d'appariement crosswalk -> exposition -- GPT: %.1f%% | AIOE: %.1f%% | union: %.1f%%\n",
            100 * match_rate_gpt, 100 * match_rate_aioe, 100 * match_rate_union))
cat("NOTE : l'ecart GPT/AIOE n'est pas du bruit -- vintages SOC differentes (AIOE = SOC2010,\n")
cat("       aligne sur le crosswalk IBS ; GPT = SOC post-2018). Voir Annexe A du draft.\n")

weight_rate <- merged[!is.na(gpt_alpha), mean(!is.na(tot_emp))]
cat(sprintf("Parmi les SOC matches GPT, part avec un poids d'emploi OEWS : %.1f%%\n", 100 * weight_rate))

# Moyenne ponderee par l'emploi US (TOT_EMP) ; si un SOC matche n'a pas de poids OEWS,
# il est exclu de la ponderation (poids implicite 0) sauf si AUCUN SOC du groupe n'a de
# poids, auquel cas on retombe sur la moyenne simple pour ce code ISCO (cf. entete).
wavg <- function(x, w) {
  ok <- !is.na(x)
  x <- x[ok]; w <- w[ok]
  if (length(x) == 0) return(NA_real_)
  if (all(is.na(w)) || sum(w, na.rm = TRUE) == 0) return(mean(x))
  w[is.na(w)] <- 0
  sum(x * w) / sum(w)
}

# --- 5. Agregation au niveau ISCO-08 (moyenne ponderee par l'emploi US OEWS) ---
# NOTE (corrige le 2026-08-13, cf. revue croisee Codex/AGY) : le filtre portait avant
# uniquement sur !is.na(gpt_alpha), ce qui supprimait silencieusement les codes ISCO-08
# ayant un score AIOE mais pas de score GPT (~30 codes, cf. mismatch de vintage SOC
# documente ci-dessus). Filtre elargi a l'union GPT|AIOE.
isco_exposure <- merged[!is.na(gpt_alpha) | !is.na(aioe), .(
  gpt_alpha_mean   = wavg(gpt_alpha, tot_emp),
  gpt_beta_mean    = wavg(gpt_beta,  tot_emp),
  gpt_gamma_mean   = wavg(gpt_gamma, tot_emp),
  aioe_mean        = wavg(aioe,      tot_emp),
  n_soc_matched_gpt  = sum(!is.na(gpt_alpha)),
  n_soc_matched_aioe = sum(!is.na(aioe)),
  n_soc_sans_poids   = sum(is.na(tot_emp))
), by = isco08][order(isco08)]

cat("\nTable finale : exposition par code ISCO-08 ->", nrow(isco_exposure), "codes\n")
print(head(isco_exposure, 15))

out_path <- file.path(out_dir, "isco08_ai_exposure_scores.csv")
fwrite(isco_exposure, out_path)
cat("\nEcrit :", out_path, "\n")

# --- Diagnostic : codes ISCO-08 sans aucun score (a documenter en 4.2 Step 3 / sensibilite) ---
all_isco <- unique(soc_isco$isco08)
unmatched_isco <- setdiff(all_isco, isco_exposure$isco08)
cat("\nCodes ISCO-08 presents dans le crosswalk mais sans score d'exposition :", length(unmatched_isco), "\n")

# --- Diagnostic : effet de la ponderation vs. la moyenne simple (backup pre-ponderation) ---
backup_path <- file.path(out_dir, "isco08_ai_exposure_scores_UNWEIGHTED_backup.csv")
if (file.exists(backup_path)) {
  unw <- fread(backup_path)[, .(isco08, gpt_alpha_unw = gpt_alpha_mean, aioe_unw = aioe_mean)]
  cmp <- merge(isco_exposure[, .(isco08, gpt_alpha_mean, aioe_mean)], unw, by = "isco08")
  cmp[, `:=`(d_gpt = gpt_alpha_mean - gpt_alpha_unw, d_aioe = aioe_mean - aioe_unw)]
  cat("\n--- Effet de la ponderation OEWS vs. moyenne simple (n =", nrow(cmp), "codes ISCO) ---\n")
  cat(sprintf("GPT alpha  : ecart absolu moyen = %.4f | ecart max = %.4f | corr = %.4f\n",
              mean(abs(cmp$d_gpt)), max(abs(cmp$d_gpt)), cor(cmp$gpt_alpha_mean, cmp$gpt_alpha_unw)))
  cat(sprintf("AIOE       : ecart absolu moyen = %.4f | ecart max = %.4f | corr = %.4f\n",
              mean(abs(cmp$d_aioe), na.rm = TRUE), max(abs(cmp$d_aioe), na.rm = TRUE),
              cor(cmp$aioe_mean, cmp$aioe_unw, use = "complete.obs")))
}
