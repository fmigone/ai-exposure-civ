# Analyse des donnees OpenAI Signals (ChatGPT, lance le 2026-08-06) pour la Cote d'Ivoire (CI),
# en parallele de l'analyse AEI/Claude (scripts 12-14). Objectif : verifier si le "narrow
# professional enclave" documente sur Claude (Handa et al. 2026, section 5.3.1 du draft) se
# retrouve aussi sur ChatGPT, qui est le produit IA le plus utilise en CIV en volume absolu.
#
# Donnees publiques, deja agregees et proteges par confidentialite differentielle par OpenAI
# (cf. data/raw/openai_signals/README.pdf) -> lecture directe OK.

library(data.table)

root <- "C:/Users/f.migone/Desktop/perso/ai_exposure_in_informal_developping_economies"
in_dir  <- file.path(root, "data/raw/openai_signals")
out_dir <- file.path(root, "data/processed")
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

# --- 1. Rang par usage per capita (trimestriel, ~147 pays avec estimation complete) ---
rank_dt <- fread(file.path(in_dir, "share_of_messages_by_country_quarter_rank.csv"))
n_countries_last_q <- rank_dt[quarter == max(quarter), .N]
ci_rank <- rank_dt[country == "CI"]
cat("Pays avec estimation complete, dernier trimestre :", n_countries_last_q, "\n")
cat("Rang CIV par trimestre (1 = usage per capita le plus eleve) :\n")
print(ci_rank[order(quarter)])

peers <- rank_dt[quarter == max(quarter) & country %in% c("FR", "US", "GH", "NG", "SN", "CI")]
cat("\nComparaison regionale, dernier trimestre :\n")
print(peers[order(rank)])

# --- 2. Part des messages lies au travail : CIV vs. moyenne mondiale ---
work_ci     <- fread(file.path(in_dir, "share_of_messages_by_work_related_country_month.csv"))[country == "CI"]
work_global <- fread(file.path(in_dir, "share_of_messages_by_work_related_month.csv"))

work_ci_last     <- work_ci[month == max(month) & work_related == 1, share_of_messages]
work_global_last <- work_global[month == max(month) & work_related == 1, share_of_messages]
cat(sprintf("\nPart des messages lies au travail, dernier mois -- CIV : %.1f%% | Monde : %.1f%%\n",
            100 * work_ci_last, 100 * work_global_last))

# --- 3. Repartition thematique CIV, dernier mois disponible ---
topic_ci <- fread(file.path(in_dir, "share_of_messages_by_topic_country_month.csv"))[country == "CI"]
topic_ci_last <- topic_ci[month == max(month)][order(-share_of_messages)]
cat("\nRepartition thematique CIV, dernier mois (", as.character(topic_ci_last$month[1]), ") :\n")
print(topic_ci_last[, .(topic, share_of_messages)])

# --- 4. Ecrit un resume agrege, aligne sur les scripts 12-14 (AEI) pour comparaison directe ---
summary_dt <- rbindlist(list(
  data.table(metric = "rank_per_capita_last_quarter", value = ci_rank[quarter == max(quarter), rank],
             detail = paste0("sur ", n_countries_last_q, " pays, trimestre ", ci_rank[quarter == max(quarter), quarter])),
  data.table(metric = "work_related_share_civ", value = work_ci_last, detail = "dernier mois disponible"),
  data.table(metric = "work_related_share_global", value = work_global_last, detail = "dernier mois disponible"),
  topic_ci_last[, .(metric = paste0("topic_share_", gsub("[^A-Za-z]", "_", topic)), value = share_of_messages,
                     detail = "dernier mois disponible")]
))

out_path <- file.path(out_dir, "openai_signals_civ_summary.csv")
fwrite(summary_dt, out_path)
cat("\nEcrit :", out_path, "\n")
