# AI Exposure in a Dual Labor Market — Project Repository

## Structure

```
ai-exposure-civ/
├── README.md
├── paper/
│   └── draft_v0.md          ← Working paper draft
├── data/                    ← Raw & processed data (not tracked)
├── scripts/                 ← R / Stata / Python scripts
├── figures/                 ← Generated figures & maps
├── notes/                   ← Research notes, literature
└── output/                  ← Final outputs (PDF, tables)
```

## Data sources

| Source | Description | Access |
|--------|-------------|--------|
| ENE-M | Panel emploi ménages, micro-données CITP-08 | ANStat interne |
| GPAI scores | Eloundou et al. 2023 — exposure by O*NET SOC | GitHub (public) |
| AIOE scores | Felten et al. 2021 — AI occupational exposure | GitHub (public) |
| Anthropic Economic Index | Usage by country × occupation | Hugging Face (public) |
| CITP-08 ↔ SOC crosswalk | ILO / BLS concordance | ILO ILOSTAT (public) |
| EHCVM 2021 | Accès TIC ménages/entreprises | ANStat / Banque mondiale |

## Timeline

- **M1** : Crosswalk, merge, descriptives
- **M2** : Exposition standard + ajustement informalité
- **M3** : Gap exposition–usage, rédaction
- **M4** : Révision, soumission WP
