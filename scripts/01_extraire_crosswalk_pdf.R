# Extraction du texte brut du crosswalk O*NET-SOC <-> ISCO-08 (document public IBS)
# Objectif : inspecter la structure avant de parser un tableau structuré.

library(pdftools)

root <- "C:/Users/f.migone/Desktop/perso/ai_exposure_in_informal_developping_economies"
pdf_path <- file.path(root, "data/raw/crosswalks/onetsoc_to_isco08_crosswalk_IBS.pdf")

txt <- pdf_text(pdf_path)
cat("Nombre de pages :", length(txt), "\n\n")

cat("--- Page 1 ---\n")
cat(txt[[1]])
cat("\n\n--- Page 2 (si existe) ---\n")
if (length(txt) >= 2) cat(txt[[2]])
