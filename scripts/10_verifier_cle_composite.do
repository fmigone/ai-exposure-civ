* Vérifie l'unicité de la clé composite interview_key + membres_id sur le sous-ensemble déjà extrait (léger, pas besoin de recharger le fichier complet).

capture log close
log using "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\scripts\_logs\verif_cle_composite.log", replace text

use "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\data\processed\enem_citp_base.dta", clear
di "N total : " _N
duplicates report interview_key membres_id

log close
