# Vérifie la présence et la couverture de la Côte d'Ivoire dans les données
# Anthropic Economic Index (données publiques, pas de contrainte de confidentialité).

library(data.table)

root <- "C:/Users/f.migone/Desktop/perso/ai_exposure_in_informal_developping_economies"
aei_dir <- file.path(root, "data/raw/anthropic_economic_index")

df <- fread(file.path(aei_dir, "aei_enriched_claude_ai_country_2025-08.csv"))
cat("Dimensions totales :", nrow(df), "x", ncol(df), "\n")
cat("Colonnes :", paste(names(df), collapse = ", "), "\n\n")

# Codes ISO possibles pour la Côte d'Ivoire : CI (alpha-2), CIV (alpha-3)
civ_rows <- df[geo_id %in% c("CI", "CIV")]
cat("Nombre de lignes pour la Côte d'Ivoire (CI/CIV) :", nrow(civ_rows), "\n\n")

if (nrow(civ_rows) > 0) {
  cat("Facettes disponibles pour la Côte d'Ivoire :\n")
  print(civ_rows[, .N, by = facet])
  cat("\nVariables disponibles (niveau 'country', facet='country') :\n")
  print(civ_rows[facet == "country", .(variable, cluster_name, value)])
} else {
  cat("Côte d'Ivoire ABSENTE du fichier — probablement sous le seuil de 200 conversations.\n")
  cat("Pays africains présents dans le fichier :\n")
  # Liste des codes ISO-3 pays africains courants pour vérifier ce qui EST présent
  africa_iso3 <- c("NGA","GHA","SEN","MLI","BFA","CMR","KEN","ZAF","EGY","MAR","TUN","DZA","COD","AGO","ETH","TZA","UGA","RWA","BEN","TGO","NER","GIN","CIV")
  present <- df[geo_id %in% africa_iso3 & facet == "country" & variable == "usage_count", .(geo_id, value)]
  print(present[order(-value)])
}
