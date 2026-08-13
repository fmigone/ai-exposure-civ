library(data.table)

root <- "C:/Users/f.migone/Desktop/perso/ai_exposure_in_informal_developping_economies"
aei_dir <- file.path(root, "data/raw/anthropic_economic_index")

df <- fread(file.path(aei_dir, "aei_enriched_claude_ai_country_2025-08.csv"))
civ <- df[geo_id %in% c("CI", "CIV")]

cat("=== Automation vs augmentation (Côte d'Ivoire) ===\n")
print(civ[facet == "collaboration_automation_augmentation", .(variable, cluster_name, value)])

cat("\n=== SOC occupation groups (Côte d'Ivoire) ===\n")
print(civ[facet == "soc_occupation", .(variable, cluster_name, value)])

cat("\n=== O*NET tasks - top 10 par usage (Côte d'Ivoire) ===\n")
onet_civ <- civ[facet == "onet_task" & variable == "onet_task_pct"]
print(onet_civ[order(-value)][1:10, .(cluster_name, value)])

cat("\n=== Comparaison usage_per_capita_index : quelques pays africains + benchmarks ===\n")
compare_countries <- c("CIV","NGA","GHA","SEN","KEN","ZAF","MAR","EGY","USA","GBR","IND","BRA","COL")
comp <- df[geo_id %in% compare_countries & facet == "country" & variable %in% c("usage_per_capita_index","usage_count","usage_tier","gdp_per_working_age_capita")]
comp_wide <- dcast(comp, geo_id ~ variable, value.var = "value", fun.aggregate = function(x) x[1])
print(comp_wide)
