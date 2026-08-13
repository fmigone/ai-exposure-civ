capture log close
log using "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\scripts\_logs\fusion_consolidation.log", replace text

local proc "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\data\processed"

use "`proc'\_tmp_codif_T1.dta", clear
append using "`proc'\_tmp_codif_T2.dta"
append using "`proc'\_tmp_codif_T3.dta"
di "Total lignes codification (T1+T2+T3) : " _N

duplicates tag interview_key membres_id, gen(dup_tag)
di "=== Doublons par trimestre_codif ==="
tab trimestre_codif if dup_tag > 0
duplicates drop interview_key membres_id, force
drop dup_tag
di "N après suppression des doublons : " _N
save "`proc'\citp_codification_25T1_T2_T3.dta", replace

* --- Fusion sur le sous-ensemble ENE-M ---
use "`proc'\enem_citp_base.dta", clear
merge 1:1 interview_key membres_id using "`proc'\citp_codification_25T1_T2_T3.dta"
di ""
di "=== Résultat de la fusion, par trimestre ==="
tab trimestre _merge, missing
drop if _merge == 2
rename _merge _merge_codif

* --- Variable finale consolidée ---
gen long citp_final = .
replace citp_final = code_citp_emp_principal if inlist(trimestre, "24T3", "24T4", "26T1")
replace citp_final = code_citp3_emp_principal if trimestre == "25T4"
replace citp_final = citp_codif if inlist(trimestre, "25T1", "25T2", "25T3") & citp_final == .

gen has_citp_final = !missing(citp_final)
di ""
di "=== Couverture finale de citp_final, par trimestre (parmi en_emp==1) ==="
tab trimestre has_citp_final if en_emp == 1, missing row

di ""
di "=== Couverture finale globale (en_emp==1) ==="
count if en_emp == 1
count if en_emp == 1 & !missing(citp_final)

save "`proc'\enem_citp_emploi_principal_consolide.dta", replace

log close
