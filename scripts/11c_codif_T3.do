capture log close
log using "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\scripts\_logs\codif_T3.log", replace text

local base "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\data\raw\enem\codifications_manquantes"
local proc "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\data\processed"

import excel using "`base'\T3_2025\Codification_T3_2025\codification_emploi_principal_T3_2025.xlsx", sheet("Sheet1") firstrow clear
keep InterviewkeyidentifierinXX Idinmembres code_citp_emp_principal
destring code_citp_emp_principal, replace force
rename InterviewkeyidentifierinXX interview_key
rename Idinmembres membres_id
rename code_citp_emp_principal citp_codif
gen trimestre_codif = "25T3"
keep interview_key membres_id citp_codif trimestre_codif
di "N T3 : " _N
save "`proc'\_tmp_codif_T3.dta", replace

log close
