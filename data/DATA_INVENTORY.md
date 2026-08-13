# Inventaire des données — AI Exposure in a Dual Labor Market (Côte d'Ivoire)

Dernière mise à jour : 2026-08-13

Basé sur les 5 sources listées en section 4.1 du draft (`paper/draft_v0.md`), plus le crosswalk ISCO-SOC (section 4.2) et DATAFID comme source retenue pour l'ajustement TIC (remplace l'EHCVM pour cet usage).

## Statut par source

| # | Source | Statut | Emplacement local | URL |
|---|--------|--------|--------------------|-----|
| 1 | **ENE-M** (micro-données emploi, ISCO-08, formalité, TIC) | ✅ Fourni par l'utilisateur | `data/raw/enem/Base_Travail_BT_vf_26T1.dta` | — |
| 2 | **GPT exposure (Eloundou et al. 2024)** | ✅ Collecté | `data/raw/exposure_indices/eloundou_gpts_are_gpts/occ_level.csv` | [github.com/openai/GPTs-are-GPTs](https://github.com/openai/GPTs-are-GPTs) |
| 3 | **AIOE (Felten, Raj & Seamans 2021)** | ✅ Collecté | `data/raw/exposure_indices/felten_aioe/AIOE_DataAppendix.xlsx` | [github.com/AIOE-Data/AIOE](https://github.com/AIOE-Data/AIOE) |
| 4 | **Pizzinelli et al. 2023 (IMF WP 23/216)** | ✅ Papier collecté (PDF) — pas de fichier de réplication public trouvé | `data/raw/literature/pizzinelli_et_al_2023_imf_wp23216.pdf` | [imf.org WP 23/216](https://www.imf.org/-/media/files/publications/wp/2023/english/wpiea2023216-print-pdf.pdf) |
| 5 | **Crosswalk ISCO-08 ↔ SOC** | ✅ Collecté (version PDF, substitut) | `data/raw/crosswalks/onetsoc_to_isco08_crosswalk_IBS.pdf` | [IBS crosswalk](https://ibs.org.pl/wp-content/uploads/2022/11/onetsoc_to_isco_cws_ibs_en1-1.pdf) |
| 6 | **DATAFID 2023 (accès TIC ménages)** — source retenue pour l'ajustement TIC (Spécification B, section 4.4) | ✅ Rapport + questionnaire collectés · 🟡 Micro-données à fournir en interne (ANStat) | `data/raw/datafid/` | [anstat.ci — étude DATAFID](https://www.anstat.ci/etude-details/3e67fa3d4bbf89f8762a8ef09c5b21f64962bf28ccae2e000130cc374ebf6b9a44612b1e7803a24e175086252e1ab3a092412fbfef9c39833e2f8cb1e4527131zbjhKkmiRIInJ1dFJPS-iIpc_8-nx0JiPlur4YrrgWg/1) |
| 7 | **EHCVM 2021** (accès TIC ménages, en réserve) | ✅ Fourni par l'utilisateur | `data/raw/ehcvm/` (Datain/Dataout/Programs/Documents) | [microdata.worldbank.org/catalog/6273](https://microdata.worldbank.org/index.php/catalog/6273) |
| 8 | **Anthropic Economic Index** | ✅ Collecté (fichiers clés) | `data/raw/anthropic_economic_index/` | [huggingface.co/datasets/Anthropic/EconomicIndex](https://huggingface.co/datasets/Anthropic/EconomicIndex) |

## Détail des fichiers collectés

### Exposure indices
- `eloundou_gpts_are_gpts/occ_level.csv` — scores GPT E1 (alpha), E1+0.5×E2 (beta), E1+E2 (gamma), par SOC/O*NET, ratings humains et GPT-4.
- `felten_aioe/AIOE_DataAppendix.xlsx` — scores AIOE par code SOC à 6 chiffres (annexe A), plus matrices de pertinence application-capacité.

### Crosswalk
- `crosswalks/onetsoc_to_isco08_crosswalk_IBS.pdf` — concordance O\*NET-SOC ↔ ISCO-08 (Institute for Structural Research, Pologne). **Note :** le fichier officiel BLS (`bls.gov/soc/isco_soc_crosswalk.xls`) est bloqué par une protection anti-bot (403 persistant même avec en-têtes navigateur) — à récupérer manuellement via navigateur si une version alternative est nécessaire pour croiser avec la version IBS.

### Anthropic Economic Index (release 2025-03-27 et 2025-09-15)
- `automation_vs_augmentation_v2.csv` — répartition automation vs. augmentation par type d'interaction.
- `task_pct_v2.csv` — parts d'usage par tâche/occupation.
- `aei_enriched_claude_ai_country_2025-08.csv` — usage Claude.ai enrichi par géographie (semaine du 2025-08-04), avec indices dérivés et per-capita. **Fichier volumineux (~26 Mo)** — c'est la table clé pour le mapping pays.
- `onet_task_statements.csv` — tâches O\*NET mappées aux groupes SOC majeurs.
- `soc_structure.csv` — hiérarchie de classification SOC 2019.
- `iso_country_codes.csv`, `gdp_2024_country.csv`, `working_age_pop_2024_country.csv` — variables de contrôle pays (nécessaires pour normaliser l'usage par habitant/PIB).

### ENE-M
- `enem/Base_Travail_BT_vf_26T1.dta` — base « Travail », panel pooled sur 7 trimestres (24T3→26T1), ~4,9 Go, 177 011 lignes, 1850 variables. **Jamais ouvert directement** — traitement exclusivement scripté (Stata), sorties limitées à des agrégats (voir mémoire `feedback-no-read-on-survey-microdata`).
- `enem/codifications_manquantes/` — 3 fichiers `emploi_principal_*.xlsx` (T1/T2/T3 2025, fournis par l'utilisateur en `.rar`, extraits avec 7-Zip) contenant les codes CITP emploi principal manquants de la base, + nomenclature `Métiers_professions_Afristat.xlsx` (ISCO-08 FR et correspondance AFRISTAT↔ISCO, non confidentielle).
- **Variable CITP consolidée** : `data/processed/enem_citp_emploi_principal_consolide.dta` (clé `interview_key`+`membres_id`, variable `citp_final`) — 86,9% de couverture parmi les actifs occupés après intégration des fichiers de codification. Détail complet de la construction : mémoire `project-pipeline-citp-enem`.

### EHCVM 2021
Dossier de travail complet fourni par l'utilisateur (pas seulement les micro-données) : `Datain/` (modules Ménage s00-s21, Commune, Auxiliaire — pondérations, prix, conversion calorique), `Dataout/` (agrégats construits : consommation, bien-être, indicateurs NSU, prix unitaires), `Programs/` (`.do` Stata de construction des indicateurs), `Documents/` (questionnaires `.xlsm`, notes méthodo pauvreté), `IO/` (tableaux entrées-sorties historiques CIV 1995-2023). Un doublon imbriqué (`Datain/Datain`, `Dataout/Dataout`, `Programs/Programs`, `Documents/Documents`, ~2,77 Go) a été supprimé le 2026-08-13. Le sous-dossier `reference_external/` (rapports ANARE, BCEAO, annuaire ANStat — hors-sujet pour ce papier) a été conservé tel quel à la demande de l'utilisateur. **Non ouvert** — même règle de confidentialité que l'ENE-M.

### DATAFID (Enquête sur l'accès et l'utilisation des TIC par les ménages, 2023)
- `datafid/rapport_datafid_2023.pdf` — rapport d'enquête complet (1 728 ménages, 864 urbain/864 rural, 144 grappes) : équipement TIC des ménages, accès/usage internet et achats en ligne par individu.
- `datafid/questionnaire_datafid_menages.pdf` — questionnaire ménage, utile pour identifier les variables exactes disponibles (dont le découpage par grand secteur d'activité retenu pour la Spécification B de l'ajustement TIC).
- **Micro-données** : non trouvées en accès libre (absentes du portail NADA public `nada.anstat.ci`) — probablement accessibles en interne via le centre de calcul ANStat (`centredecalcul.anstat.ci`). À fournir par l'utilisateur comme pour l'ENE-M.

### Littérature (référence, pas données structurées)
- `literature/pizzinelli_et_al_2023_imf_wp23216.pdf` — papier complet (benchmarks 6 pays, tables d'exposition par ISCO en annexe, à extraire manuellement si besoin de reproduire leurs chiffres).

## Ce qui reste à obtenir

1. **Micro-données DATAFID** — l'utilisateur fournira le fichier en interne (accès ANStat), le rapport et le questionnaire sont déjà collectés.
2. **Crosswalk BLS xls officiel** (optionnel) — à télécharger manuellement via navigateur si la version IBS s'avère insuffisante pour l'agrégation many-to-many décrite en section 4.2 du draft.
3. **Demombynes, Langbein & Weber (2025, World Bank PRWP 11057)** — cité comme concurrent direct mais pas encore collecté ; utile pour benchmark 25 pays. À ajouter si besoin.

## Toutes les sources cœur du papier (ENE-M, exposition, crosswalk, Anthropic Economic Index, EHCVM) sont désormais réunies. Seule DATAFID micro-données manque encore.
