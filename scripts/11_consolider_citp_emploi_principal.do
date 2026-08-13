* Consolide la variable CITP "emploi principal" sur l'ensemble du panel ENE-M :
*  - 24T3, 24T4, 26T1 : code_citp_emp_principal (base)
*  - 25T4            : code_citp3_emp_principal (base)
*  - 25T1, 25T2, 25T3 : fichiers de codification fournis par l'utilisateur, fusionnés
*                       via la clé composite interview_key + membres_id
* Sortie = uniquement des comptages agrégés (aucune valeur individuelle affichée).

capture log close
log using "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\scripts\_logs\consolidation_citp.log", replace text

local base "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\data\raw\enem\codifications_manquantes"
local proc "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\data\processed"

* --- T1 2025 : garder codecorrigé en priorité, sinon code_citp_emp_principal ---
import excel using "`base'\T1_2025\Emploi_codif\emploi_principal_1.xlsx", sheet("Sheet1") firstrow clear
keep InterviewkeyidentifierinXX Idinmembres code_citp_emp_principal codecorrigé
destring code_citp_emp_principal, replace force
gen long citp_codif = codecorrigé
replace citp_codif = code_citp_emp_principal if missing(citp_codif)
rename InterviewkeyidentifierinXX interview_key
rename Idinmembres membres_id
gen trimestre_codif = "25T1"
keep interview_key membres_id citp_codif trimestre_codif
save "`proc'\_tmp_codif_T1.dta", replace

* --- T2 2025 ---
import excel using "`base'\T2_2025\Emploi_codif_T2\emploi_principal_2eT.xlsx", sheet("Sheet1") firstrow clear
keep InterviewkeyidentifierinXX Idinmembres code_citp_emp_principal
destring code_citp_emp_principal, replace force
rename InterviewkeyidentifierinXX interview_key
rename Idinmembres membres_id
rename code_citp_emp_principal citp_codif
gen trimestre_codif = "25T2"
keep interview_key membres_id citp_codif trimestre_codif
save "`proc'\_tmp_codif_T2.dta", replace

* --- T3 2025 ---
import excel using "`base'\T3_2025\Codification_T3_2025\codification_emploi_principal_T3_2025.xlsx", sheet("Sheet1") firstrow clear
keep InterviewkeyidentifierinXX Idinmembres code_citp_emp_principal
destring code_citp_emp_principal, replace force
rename InterviewkeyidentifierinXX interview_key
rename Idinmembres membres_id
rename code_citp_emp_principal citp_codif
gen trimestre_codif = "25T3"
keep interview_key membres_id citp_codif trimestre_codif
save "`proc'\_tmp_codif_T3.dta", replace

* --- Empile les 3 trimestres de codification ---
use "`proc'\_tmp_codif_T1.dta", clear
append using "`proc'\_tmp_codif_T2.dta"
append using "`proc'\_tmp_codif_T3.dta"
di "Total lignes codification (T1+T2+T3) : " _N
duplicates report interview_key membres_id
di "=== Doublons détectés (trimestre_codif uniquement, pas de valeur individuelle) ==="
duplicates tag interview_key membres_id, gen(dup_tag)
tab trimestre_codif if dup_tag > 0
duplicates drop interview_key membres_id, force
di "N après suppression des doublons : " _N
save "`proc'\citp_codification_25T1_T2_T3.dta", replace

* --- Fusion sur le sous-ensemble ENE-M déjà extrait ---
use "`proc'\enem_citp_base.dta", clear
merge 1:1 interview_key membres_id using "`proc'\citp_codification_25T1_T2_T3.dta"
tab trimestre _merge, missing
drop if _merge == 2
rename _merge _merge_codif

* --- Construction de la variable finale consolidée ---
gen long citp_final = .
replace citp_final = code_citp_emp_principal if inlist(trimestre, "24T3", "24T4", "26T1")
replace citp_final = code_citp3_emp_principal if trimestre == "25T4"
replace citp_final = citp_codif if inlist(trimestre, "25T1", "25T2", "25T3") & citp_final == .

gen has_citp_final = !missing(citp_final)
di ""
di "=== Couverture finale de citp_final, par trimestre (parmi en_emp==1) ==="
tab trimestre has_citp_final if en_emp == 1, missing row
di ""
di "=== Nombre de codes ISCO/CITP distincts dans citp_final (parmi en_emp==1) ==="
quietly levelsof citp_final if en_emp == 1, local(codes)
di "Nb codes distincts : " wordcount("`codes'")

save "`proc'\enem_citp_emploi_principal_consolide.dta", replace

log close
