# Inventaire des variables DATAFID (CM, Entreprise, Individu) — métadonnées uniquement
# (noms, types, libellés, stats agrégées). Objectif : repérer les variables TIC/accès
# numérique et la variable de secteur (ISIC/CITI) pour la Spécification B (§4.4 du draft).
# Bascule sur R (au lieu de Stata, qui restait bloqué sans jamais écrire son log -- deux
# tentatives, l'une ~40 min sans progression CPU) : haven lit les .dta sans ouvrir Stata.
#
# Ne JAMAIS imprimer d'observations individuelles (head(), print(df), View()) -- seulement
# des métadonnées et des statistiques agrégées, conformement a la consigne confidentialite.

library(haven)
library(data.table)

root <- "C:/Users/f.migone/Desktop/perso/ai_exposure_in_informal_developping_economies"
in_dir <- file.path(root, "data/raw/datafid/extracted")
log_dir <- file.path(root, "scripts/_logs")
dir.create(log_dir, showWarnings = FALSE, recursive = TRUE)

log_path <- file.path(log_dir, "datafid_variable_inventory.log")
sink(log_path, split = TRUE)

inventaire <- function(path) {
  cat("==========================================================\n")
  cat("===", basename(path), "===\n")
  cat("==========================================================\n")
  d <- read_dta(path)
  cat("Dimensions :", nrow(d), "lignes x", ncol(d), "colonnes\n\n")

  safe <- function(f, x) tryCatch(f(x), error = function(e) NA)
  get_label <- function(x) { l <- attr(x, "label"); if (is.null(l) || length(l) != 1) "" else as.character(l) }

  meta <- data.table(
    variable   = names(d),
    label      = vapply(d, function(x) safe(get_label, x), character(1)),
    type       = vapply(d, function(x) safe(function(y) class(y)[1], x), character(1)),
    n_non_na   = vapply(d, function(x) as.integer(safe(function(y) sum(!is.na(y)), x)), integer(1)),
    n_na       = vapply(d, function(x) as.integer(safe(function(y) sum(is.na(y)), x)), integer(1)),
    n_distinct = vapply(d, function(x) as.integer(safe(function(y) length(unique(y[!is.na(y)])), x)), integer(1))
  )
  print(meta, nrows = Inf)
  cat("\n")
  rm(d); gc(verbose = FALSE)
}

for (f in c("CM_ano.dta", "Entreprise_DATAFID_ANO_VF_22-07-2024.dta", "Individu_DATAFID_ano.dta")) {
  tryCatch(
    inventaire(file.path(in_dir, f)),
    error = function(e) cat("ERREUR sur", f, ":", conditionMessage(e), "\n\n")
  )
}

sink()
cat("Ecrit :", log_path, "\n")
