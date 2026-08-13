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
| 6 | **DATAFID 2023 (accès TIC ménages/entreprises)** — source retenue pour l'ajustement TIC (Spécification B, section 4.4) | ✅ Micro-données fournies et inventoriées (2026-08-13) — 3 bases : CM (1714 obs, ménages), Entreprise (462 obs, 284 var.), Individu (6643 obs, 332 var.) | `data/raw/datafid/extracted/` (CM_ano, Entreprise_DATAFID_ANO_VF_22-07-2024, Individu_DATAFID_ano — `.dta`/`.sav`) ; inventaire agrégé : `scripts/_logs/datafid_variable_inventory.log` | [anstat.ci — étude DATAFID](https://www.anstat.ci/etude-details/3e67fa3d4bbf89f8762a8ef09c5b21f64962bf28ccae2e000130cc374ebf6b9a44612b1e7803a24e175086252e1ab3a092412fbfef9c39833e2f8cb1e4527131zbjhKkmiRIInJ1dFJPS-iIpc_8-nx0JiPlur4YrrgWg/1) |
| 7 | **EHCVM 2021** (accès TIC ménages, en réserve) | ✅ Fourni par l'utilisateur | `data/raw/ehcvm/` (Datain/Dataout/Programs/Documents) | [microdata.worldbank.org/catalog/6273](https://microdata.worldbank.org/index.php/catalog/6273) |
| 8 | **Anthropic Economic Index** | ✅ Collecté (fichiers clés) | `data/raw/anthropic_economic_index/` | [huggingface.co/datasets/Anthropic/EconomicIndex](https://huggingface.co/datasets/Anthropic/EconomicIndex) |
| 9 | **BLS OEWS (poids d'emploi national par SOC)** — pondération de l'agrégation many-to-many du crosswalk (section 4.2) | ✅ Collecté via le miroir CRAN `oews2020` (millésime mai 2020 — le site bls.gov bloque le téléchargement automatisé par protection anti-bot, même constat que pour le crosswalk officiel BLS ci-dessous) | `data/raw/exposure_indices/bls_oews/oews2020_national_soc_employment.csv` | [cran.r-project.org/package=oews2020](https://cran.r-project.org/package=oews2020) |
| 10 | **OpenAI Signals (usage ChatGPT)** — second point de vue sur l'usage observé, en parallèle de l'AEI (section 5.3) | ✅ Collecté (25 CSV + dictionnaire de données) | `data/raw/openai_signals/` | [openai.com/signals](https://openai.com/signals/data/) |

## Détail des fichiers collectés

### Exposure indices
- `eloundou_gpts_are_gpts/occ_level.csv` — scores GPT E1 (alpha), E1+0.5×E2 (beta), E1+E2 (gamma), par SOC/O*NET, ratings humains et GPT-4.
- `felten_aioe/AIOE_DataAppendix.xlsx` — scores AIOE par code SOC à 6 chiffres (annexe A), plus matrices de pertinence application-capacité.

### Crosswalk
- `crosswalks/onetsoc_to_isco08_crosswalk_IBS.pdf` — concordance O\*NET-SOC ↔ ISCO-08 (Institute for Structural Research, Pologne). **Note :** le fichier officiel BLS (`bls.gov/soc/isco_soc_crosswalk.xls`) est bloqué par une protection anti-bot (403 persistant même avec en-têtes navigateur) — à récupérer manuellement via navigateur si une version alternative est nécessaire pour croiser avec la version IBS.

### BLS OEWS (poids d'emploi)
- `bls_oews/oews2020_national_soc_employment.csv` — emploi national US par code SOC (mai 2020, tous secteurs, toutes catégories d'employeur combinées), 788 codes avec poids valide. Sert à pondérer l'agrégation many-to-many du crosswalk ISCO↔SOC (`scripts/03_construire_crosswalk_exposition_isco.R`). **Note :** comme pour le crosswalk ci-dessus, `bls.gov/oes/` bloque le téléchargement automatisé (403 anti-bot) ; contournement via le paquet CRAN `oews2020` (Christopher Mann), qui redistribue légalement les données BLS mai 2020. **Millésime problématique, pas seulement "plus ancien que souhaitable"** : découverte du 2026-08-13 (revue croisée Codex) — ce fichier mai 2020 contient en réalité des codes SOC **post-2018** (ex. `15-1251` présent, `15-1131` absent), pas du SOC2010 pur comme supposé initialement. Ceci crée une asymétrie de couverture des poids (95,8 % pour les appariements GPT, cohérents en millésime avec OEWS, contre seulement 83,6 % pour les appariements AIOE, en SOC2010 comme le crosswalk mais pas comme OEWS) — documenté en détail en Annexe A et Section 5.4 du draft, pas juste en Annexe D. Construit par `scripts/03a_extraire_poids_emploi_oews.R`.

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

### DATAFID (Enquête sur l'accès et l'utilisation des TIC par les ménages/entreprises, 2023)
- `datafid/rapport_datafid_2023.pdf` — rapport d'enquête complet (1 728 ménages, 864 urbain/864 rural, 144 grappes) : équipement TIC des ménages, accès/usage internet et achats en ligne par individu.
- `datafid/questionnaire_datafid_menages.pdf` — questionnaire ménage, utile pour identifier les variables exactes disponibles (dont le découpage par grand secteur d'activité retenu pour la Spécification B de l'ajustement TIC).
- **Micro-données** : fournies par l'utilisateur le 2026-08-13 (`datafid/DATAFID.zip`, extrait sous `datafid/extracted/`) et inventoriées — voir la ligne 6 du tableau ci-dessus et mémoire projet `project-datafid-inventory`. Note : le découpage sectoriel réel (`SECTEUR`, base Entreprise) n'a que 3 catégories (primaire/secondaire/tertiaire), plus grossier que ce que la section 4.4 du draft supposait initialement.

### Littérature (référence, pas données structurées)
- `literature/pizzinelli_et_al_2023_imf_wp23216.pdf` — papier complet (benchmarks 6 pays, tables d'exposition par ISCO en annexe, à extraire manuellement si besoin de reproduire leurs chiffres).

## Ce qui reste à obtenir

1. **Crosswalk-pont BLS SOC2010 ↔ SOC2018** — nécessaire pour réconcilier les scores GPT (SOC post-2018) avec le crosswalk IBS et AIOE (SOC2010) ; probablement bloqué par le même filtre anti-bot bls.gov que les autres fichiers BLS de ce projet — à chercher d'abord via un miroir public (CRAN, GitHub) avant de tenter le téléchargement manuel via navigateur.
2. **Poids d'emploi OEWS réellement SOC2010** — découverte du 2026-08-13 (revue croisée Codex) : le fichier `oews2020_national_soc_employment.csv` actuellement utilisé contient en réalité des codes post-2018 (ex. `15-1251` présent, `15-1131` absent), pas du SOC2010 pur comme supposé. Cela explique un taux de couverture des poids plus faible pour les appariements AIOE (83,6 %) que GPT (95,8 %) — l'inverse de ce qu'on attendrait si le fichier était SOC2010-pur. Un fichier OEWS réellement millésimé SOC2010 (années ≤2018) résoudrait ceci proprement.
3. **Demombynes, Langbein & Weber (2025, World Bank PRWP 11057)** — cité comme concurrent direct mais pas encore collecté ; utile pour benchmark 25 pays. À ajouter si besoin.

## Statut global

Toutes les sources listées dans le tableau ci-dessus sont désormais réunies (y compris les micro-données DATAFID depuis le 2026-08-13). Les chantiers ouverts sont désormais des problèmes de **cohérence de millésime de nomenclature** (SOC2010 vs SOC2018, points 1-2 ci-dessus) plutôt que d'accès aux données — voir Annexe A et Section 5.4 du draft.
