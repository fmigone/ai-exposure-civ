* Complément : teste emploi_principale_codif (candidate oubliée) et vérifie la
* couverture combinée des 7 variables sur les trimestres 25T2/25T3 (trous identifiés).

capture log close
log using "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\scripts\_logs\citp_complement.log", replace text

use "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\data\raw\enem\Base_Travail_BT_vf_26T1.dta", clear
keep if en_emp == 1

capture confirm variable emploi_principale_codif
if _rc == 0 {
    quietly count if !missing(emploi_principale_codif)
    di "emploi_principale_codif : " r(N) " non-missing / " _N
    di "--- par trimestre ---"
    tab trimestre if !missing(emploi_principale_codif)
}
else {
    di "emploi_principale_codif : VARIABLE ABSENTE"
}

di ""
di "=== Couverture combinée des 7 variables, trimestres 25T2/25T3 uniquement ==="
local candidates code_citp_emp_principal code_citp3_emp_principal emp_prin_codifie emploi_principale Codif_à_considerer codecorrigé emploi_principale_codif
egen any_citp7 = rownonmiss(`candidates')
tab trimestre if inlist(trimestre, "25T2", "25T3"), missing
count if inlist(trimestre, "25T2", "25T3") & any_citp7 > 0

log close
