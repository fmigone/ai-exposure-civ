capture log close
log using "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\scripts\_logs\codif_T2.log", replace text

local base "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\data\raw\enem\codifications_manquantes"
local proc "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\data\processed"

import excel using "`base'\T2_2025\Emploi_codif_T2\emploi_principal_2eT.xlsx", sheet("Sheet1") firstrow clear
keep InterviewkeyidentifierinXX Idinmembres code_citp_emp_principal
destring code_citp_emp_principal, replace force
rename InterviewkeyidentifierinXX interview_key
rename Idinmembres membres_id
rename code_citp_emp_principal citp_codif
gen trimestre_codif = "25T2"
keep interview_key membres_id citp_codif trimestre_codif
di "N T2 : " _N
save "`proc'\_tmp_codif_T2.dta", replace

log close
