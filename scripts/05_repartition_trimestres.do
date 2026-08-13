* Répartition complète par trimestre parmi les actifs occupés (en_emp==1)
* Objectif : identifier les vagues non couvertes par les 6 variables CITP déjà testées.

capture log close
log using "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\scripts\_logs\repartition_trimestres.log", replace text

use "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\data\raw\enem\Base_Travail_BT_vf_26T1.dta", clear
keep if en_emp == 1

tab trimestre, missing

local candidates code_citp_emp_principal code_citp3_emp_principal emp_prin_codifie emploi_principale Codif_à_considerer codecorrigé
egen any_citp = rownonmiss(`candidates')
gen has_citp = any_citp > 0

di ""
di "=== Couverture CITP (au moins une des 6 variables non-missing), par trimestre ==="
tab trimestre has_citp, row

log close
