# Teste l'hypothèse "barrière linguistique" (draft section 5.3.3) :
# les pays africains francophones ont-ils un usage IA (AEI) plus faible que les
# anglophones, à PIB/tête comparable ?
# Données publiques (Anthropic Economic Index) -> pas de contrainte de confidentialité.

library(data.table)

root <- "C:/Users/f.migone/Desktop/perso/ai_exposure_in_informal_developping_economies"
aei_dir <- file.path(root, "data/raw/anthropic_economic_index")

df <- fread(file.path(aei_dir, "aei_enriched_claude_ai_country_2025-08.csv"))

# --- Classification linguistique (langue officielle/dominante) ---
lang <- data.table(
  geo_id = c(
    # Francophone
    "BEN","BFA","BDI","CMR","CAF","TCD","COM","COG","COD","CIV","DJI","GAB",
    "GIN","MDG","MLI","NER","RWA","SEN","TGO",
    # Anglophone
    "NGA","GHA","KEN","ZAF","UGA","TZA","ZMB","ZWE","MWI","SLE","LBR","GMB",
    "BWA","NAM","SWZ","LSO","MUS",
    # Lusophone
    "AGO","MOZ","GNB","CPV","STP",
    # Arabophone (Afrique du Nord)
    "EGY","MAR","TUN","DZA","LBY","SDN","MRT"
  ),
  language = c(
    rep("Francophone", 19),
    rep("Anglophone", 17),
    rep("Lusophone", 5),
    rep("Arabophone", 7)
  )
)

# --- Extraction des indicateurs pays pour l'Afrique ---
africa <- df[geo_id %in% lang$geo_id & facet == "country" &
             variable %in% c("usage_per_capita_index","usage_count","gdp_per_working_age_capita","usage_tier")]

wide <- dcast(africa, geo_id + geo_name ~ variable, value.var = "value", fun.aggregate = function(x) x[1])
wide <- merge(wide, lang, by = "geo_id")

cat("=== Pays africains présents dans l'AEI, avec classification linguistique ===\n")
cat("N pays trouvés :", nrow(wide), "sur", nrow(lang), "candidats\n\n")
print(wide[order(language, -usage_per_capita_index)])

cat("\n=== Statistiques descriptives par groupe linguistique ===\n")
print(wide[, .(n_pays = .N,
                usage_idx_moyen = mean(usage_per_capita_index, na.rm = TRUE),
                usage_idx_median = median(usage_per_capita_index, na.rm = TRUE),
                pib_tete_moyen = mean(gdp_per_working_age_capita, na.rm = TRUE)),
            by = language])

# --- Régression : usage_per_capita_index ~ log(PIB/tête) + francophone ---
reg_data <- wide[language %in% c("Francophone", "Anglophone")]
reg_data[, log_gdp := log(gdp_per_working_age_capita)]
reg_data[, francophone := as.integer(language == "Francophone")]

cat("\n=== Régression : usage_per_capita_index ~ log(PIB/tête) + francophone ===\n")
cat("N observations (francophone+anglophone) :", nrow(reg_data), "\n")
if (nrow(reg_data) >= 5) {
  m <- lm(usage_per_capita_index ~ log_gdp + francophone, data = reg_data)
  print(summary(m))
} else {
  cat("Trop peu d'observations pour une régression fiable.\n")
}
