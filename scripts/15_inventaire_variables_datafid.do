* Inventaire des variables DATAFID (CM, Entreprise, Individu) — métadonnées uniquement
* (noms, types, libellés, stats agrégées). Objectif : repérer les variables TIC/accès
* numérique et la variable de secteur (ISIC/CITI) pour la Spécification B (§4.4 du draft).
* Ne JAMAIS ajouter de commande qui liste des observations individuelles (list, browse, edit).

set more off

capture mkdir "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\scripts\_logs"
capture log close
log using "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\scripts\_logs\datafid_variable_inventory.log", replace text

local root "C:\Users\f.migone\Desktop\perso\ai_exposure_in_informal_developping_economies\data\raw\datafid\extracted"

foreach f in "CM_ano" "Entreprise_DATAFID_ANO_VF_22-07-2024" "Individu_DATAFID_ano" {
    display as text "=========================================================="
    display as text "=== `f' ==="
    display as text "=========================================================="
    use "`root'\`f'.dta", clear
    display as text "Nombre d'observations : " _N
    describe, full
    codebook, compact
}

log close
