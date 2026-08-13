# Extrait les poids d'emploi national US par code SOC-10, pour la ponderation
# many-to-many du crosswalk ISCO-08 <-> SOC (etape 4.2, Step 2 du draft).
#
# Source : BLS Occupational Employment and Wage Statistics, national, mai 2020,
# tous secteurs (I_GROUP == "cross-industry"), tous statuts d'employeur combines
# (OWN_CODE == 1235), niveau SOC "detailed" (6 chiffres).
#
# Le telechargement direct depuis bls.gov est bloque par une protection anti-bot
# (403 Akamai persistant, meme constat que pour le crosswalk ISCO-SOC officiel,
# cf. data/DATA_INVENTORY.md). Contournement : le paquet CRAN `oews2020`
# (Christopher Mann, MIT) redistribue legalement les donnees OEWS mai 2020
# telles que publiees par le BLS (https://www.bls.gov/oes/tables.htm).
#
# Limite assumee : millesime mai 2020 (le plus recent accessible sans contourner
# le blocage), plutot que l'annee la plus recente du crosswalk d'exposition
# lui-meme. La structure relative de l'emploi entre codes SOC proches change
# lentement d'une annee sur l'autre ; ce choix est documente comme limite en
# Section 4.2 / Appendice D (sensibilite) plutot que dissimule.
#
# Donnees publiques uniquement -> lecture directe OK.

if (!requireNamespace("oews2020", quietly = TRUE)) {
  install.packages("oews2020", repos = "https://cran.r-project.org")
}

library(data.table)

root <- "C:/Users/f.migone/Desktop/perso/ai_exposure_in_informal_developping_economies"
out_dir <- file.path(root, "data/raw/exposure_indices/bls_oews")
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

data(oews2020, package = "oews2020")
dt <- as.data.table(oews2020)

nat <- dt[
  AREA_TYPE == 1 & PRIM_STATE == "US" &
  I_GROUP == "cross-industry" & OWN_CODE == 1235 &
  O_GROUP == "detailed"
]

cat("Lignes nationales, tous secteurs, niveau SOC detaille :", nrow(nat), "\n")

nat[, occ_code_chr := as.character(OCC_CODE)]
stopifnot(all(grepl("^[0-9]{2}-[0-9]{4}$", nat$occ_code_chr)))
nat[, soc10 := as.numeric(gsub("-", "", occ_code_chr))]

oews_weights <- nat[, .(soc10, occ_title = as.character(OCC_TITLE), tot_emp = as.numeric(TOT_EMP))]
oews_weights <- oews_weights[!is.na(tot_emp)]

cat("Codes SOC-10 avec poids d'emploi valide :", nrow(oews_weights), "\n")
cat("Emploi national total (somme TOT_EMP, detailed) :", format(sum(oews_weights$tot_emp), big.mark = " "), "\n")

out_path <- file.path(out_dir, "oews2020_national_soc_employment.csv")
fwrite(oews_weights, out_path)
cat("\nEcrit :", out_path, "\n")
