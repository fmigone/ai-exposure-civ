# Construit la table d'exposition IA par code ISCO-08, en fusionnant :
#   - Eloundou et al. (2024) : scores GPT (alpha/beta/gamma) au niveau O*NET-SOC
#   - Felten, Raj & Seamans (2021) : score AIOE au niveau SOC 6 chiffres
#   - Crosswalk IBS : SOC-10 <-> ISCO-08 (many-to-many)
#
# Etape 4.2 du draft (paper/draft_v0.md) : Steps 1-2 (concordance directe + agregation
# many-to-many). NOTE : agregation actuellement non ponderee par l'emploi US (BLS OEWS) --
# c'est un raffinement futur mentionne dans la methodologie, pas encore applique ici.
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

# --- 4. Fusion : SOC10 -> exposition, puis SOC10 -> ISCO08 ---
exp_soc <- merge(gpt_soc, aioe_soc, by = "soc10", all = TRUE)

merged <- merge(soc_isco, exp_soc, by = "soc10", all.x = TRUE)

match_rate <- merged[, mean(!is.na(gpt_alpha))]
cat(sprintf("Taux d'appariement crosswalk -> exposition : %.1f%%\n", 100 * match_rate))

# --- 5. Agregation au niveau ISCO-08 (moyenne non ponderee sur les SOC associes) ---
isco_exposure <- merged[!is.na(gpt_alpha), .(
  gpt_alpha_mean = mean(gpt_alpha, na.rm = TRUE),
  gpt_beta_mean  = mean(gpt_beta,  na.rm = TRUE),
  gpt_gamma_mean = mean(gpt_gamma, na.rm = TRUE),
  aioe_mean      = mean(aioe, na.rm = TRUE),
  n_soc_matched  = .N
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
