* Exhaustivité des variables CITP "emploi principal" candidates, parmi les actifs
* occupés (en_emp == 1). Sortie = comptages/pourcentages agrégés uniquement.

capture log close
log using "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\scripts\_logs\citp_exhaustivite.log", replace text

use "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\data\raw\enem\Base_Travail_BT_vf_26T1.dta", clear

capture confirm variable en_emp
if _rc {
    di as error "Variable en_emp introuvable"
    exit
}

keep if en_emp == 1
local N = _N
di "N total (en_emp==1) : `N'"

local candidates code_citp_emp_principal code_citp3_emp_principal emp_prin_codifie emploi_principale Codif_à_considerer codecorrigé

foreach v of local candidates {
    capture confirm variable `v'
    if _rc == 0 {
        quietly count if !missing(`v')
        local nm = r(N)
        di "`v' : " `nm' " non-missing / `N' (" %4.1f (100*`nm'/`N') "%)"
    }
    else {
        di "`v' : VARIABLE ABSENTE"
    }
}

capture confirm variable trimestre
if _rc == 0 {
    di ""
    di "=== Répartition par trimestre (non-missing uniquement) ==="
    foreach v of local candidates {
        capture confirm variable `v'
        if _rc == 0 {
            di "--- `v' ---"
            tab trimestre if !missing(`v')
        }
    }
}

log close
