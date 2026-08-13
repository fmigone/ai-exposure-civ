* Import des 3 fichiers de codification (feuille Sheet1) + describe pour confirmer
* les noms de variables generes par Stata (les en-tetes Excel sont longs/accentues).

capture log close
log using "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\scripts\_logs\import_codification_describe.log", replace text

local base "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\data\raw\enem\codifications_manquantes"

di "=== T1 2025 ==="
import excel using "`base'\T1_2025\Emploi_codif\emploi_principal_1.xlsx", sheet("Sheet1") firstrow clear
describe, full
di "N = " _N

di "=== T2 2025 ==="
import excel using "`base'\T2_2025\Emploi_codif_T2\emploi_principal_2eT.xlsx", sheet("Sheet1") firstrow clear
describe, full
di "N = " _N

di "=== T3 2025 ==="
import excel using "`base'\T3_2025\Codification_T3_2025\codification_emploi_principal_T3_2025.xlsx", sheet("Sheet1") firstrow clear
describe, full
di "N = " _N

log close
