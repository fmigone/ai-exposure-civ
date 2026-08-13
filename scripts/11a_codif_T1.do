capture log close
log using "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\scripts\_logs\codif_T1.log", replace text

local base "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\data\raw\enem\codifications_manquantes"
local proc "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\data\processed"

import excel using "`base'\T1_2025\Emploi_codif\emploi_principal_1.xlsx", sheet("Sheet1") firstrow clear
keep InterviewkeyidentifierinXX Idinmembres code_citp_emp_principal codecorrigé
destring code_citp_emp_principal, replace force
gen long citp_codif = codecorrigé
replace citp_codif = code_citp_emp_principal if missing(citp_codif)
rename InterviewkeyidentifierinXX interview_key
rename Idinmembres membres_id
gen trimestre_codif = "25T1"
keep interview_key membres_id citp_codif trimestre_codif
di "N T1 : " _N
save "`proc'\_tmp_codif_T1.dta", replace

log close
