* Extrait un sous-ensemble léger de l'ENE-M (clés + variables CITP + trimestre)
* pour éviter de recharger le fichier complet (1850 var., 4.9Go) à chaque étape.

capture log close
log using "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\scripts\_logs\extraction_sous_ensemble.log", replace text

use interview_key interview_id cle_individu membres_id rang_ind trimestre en_emp code_citp_emp_principal code_citp3_emp_principal emp_prin_codifie emploi_principale Codif_à_considerer codecorrigé emploi_principale_codif ///
    using "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\data\raw\enem\Base_Travail_BT_vf_26T1.dta", clear

di "N total : " _N
duplicates report interview_id
duplicates report interview_key
duplicates report cle_individu

save "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\data\processed\enem_citp_base.dta", replace

log close
