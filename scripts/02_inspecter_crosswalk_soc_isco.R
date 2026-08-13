# Inspection de la table crosswalk publique SOC-10 <-> ISCO-08 (IBS) et onetsoc09->onetsoc10
# Donnees publiques de reference, pas de micro-donnees d'enquete -> lecture directe OK.

library(haven)
library(data.table)

root <- "C:/Users/f.migone/Desktop/perso/ai_exposure_in_informal_developping_economies"
cw_dir <- file.path(root, "data/raw/crosswalks/onetsoc_to_isco_ibs/onetsoc_to_isco_cws_ibs")

soc_isco <- as.data.table(read_dta(file.path(cw_dir, "soc10_isco08.dta")))
cat("=== soc10_isco08.dta ===\n")
cat("Dimensions:", nrow(soc_isco), "x", ncol(soc_isco), "\n")
print(str(soc_isco))
print(head(soc_isco, 10))

onet09_10 <- as.data.table(read_dta(file.path(cw_dir, "onetsoc09_onetsoc10.dta")))
cat("\n=== onetsoc09_onetsoc10.dta ===\n")
cat("Dimensions:", nrow(onet09_10), "x", ncol(onet09_10), "\n")
print(str(onet09_10))
print(head(onet09_10, 10))
