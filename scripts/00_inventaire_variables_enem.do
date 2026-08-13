* Inventaire des variables ENE-M — métadonnées uniquement (noms, types, libellés, stats agrégées)
* Ne JAMAIS ajouter de commande qui liste des observations individuelles (list, browse, edit)

capture mkdir "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\scripts\_logs"
capture log close
log using "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\scripts\_logs\enem_variable_inventory.log", replace text

use "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\data\raw\enem\Base_Travail_BT_vf_26T1.dta", clear

describe, full
codebook, compact

log close
