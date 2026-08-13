# Inspection des fichiers de codification emploi_principal (T1/T2/T3 2025) + nomenclature Afristat.
# Ces fichiers contiennent potentiellement du texte verbatim individuel (intitulés de poste
# saisis par les enquêteurs) -> on n'affiche QUE les noms de colonnes et le nombre de lignes,
# jamais le contenu des cellules (cf. memoire feedback-no-read-on-survey-microdata).

library(readxl)

root <- "C:/Users/f.migone/Desktop/perso/ai_exposure_in_informal_developping_economies"
base <- file.path(root, "data/raw/enem/codifications_manquantes")

files <- list(
  T1_principal = file.path(base, "T1_2025/Emploi_codif/emploi_principal_1.xlsx"),
  T1_afristat  = file.path(base, "T1_2025/Emploi_codif/Métiers_professions_Afristat.xlsx"),
  T2_principal = file.path(base, "T2_2025/Emploi_codif_T2/emploi_principal_2eT.xlsx"),
  T3_principal = file.path(base, "T3_2025/Codification_T3_2025/codification_emploi_principal_T3_2025.xlsx")
)

for (nm in names(files)) {
  f <- files[[nm]]
  cat("=====", nm, "=====\n")
  cat("Fichier:", basename(f), "\n")
  sheets <- excel_sheets(f)
  cat("Feuilles:", paste(sheets, collapse = ", "), "\n")
  for (sh in sheets) {
    # n_max=0 -> lit uniquement l'en-tete, aucune ligne de donnees
    hdr <- tryCatch(read_excel(f, sheet = sh, n_max = 0), error = function(e) NULL)
    if (!is.null(hdr)) {
      cat("  Feuille '", sh, "' - colonnes: ", paste(names(hdr), collapse = " | "), "\n", sep = "")
    }
    # Comptage de lignes sans charger le contenu (juste la dimension)
    full <- tryCatch(read_excel(f, sheet = sh), error = function(e) NULL)
    if (!is.null(full)) {
      cat("  Feuille '", sh, "' - nb lignes: ", nrow(full), "\n", sep = "")
    }
  }
  cat("\n")
}
