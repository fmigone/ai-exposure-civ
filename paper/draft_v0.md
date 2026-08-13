# AI Exposure in a Dual Labor Market: Evidence from Côte d'Ivoire's National Employment Survey

**Franck Arnold Junior Migone**

Sous-Directeur de l'Innovation Méthodologique, Cellule d'Analyses Économiques (CAE/DERI)
Agence Nationale de la Statistique (ANStat), Côte d'Ivoire

*Draft — August 2026*

---

**Abstract.** How exposed are workers in economies with predominantly informal employment to the labor market disruptions of artificial intelligence? This paper provides the first systematic mapping of AI occupational exposure indices onto a West African labor force, using micro-data from Côte d'Ivoire's Enquête Nationale sur l'Emploi auprès des Ménages (ENE-M). I apply three established exposure measures — the GPT exposure scores of Eloundou et al. (2024), the AI Occupational Exposure index of Felten, Raj, and Seamans (2021), and the complementarity-adjusted framework of Pizzinelli et al. (2023) — to the full occupational distribution of the Ivorian labor force, coded at the 4-digit ISCO-08 level. The headline finding is that standard indices substantially overstate effective AI exposure in a dual labor market where approximately 90 percent of employment is informal. I propose an informality-adjusted exposure measure that accounts for the divergence between the theoretical task content of an occupation (as described in O\*NET) and its actual task content in the informal sector, using digital access variables from the ENE-M and the EHCVM as adjustment factors. The adjusted measure reduces aggregate national exposure by [XX] percent relative to the unadjusted benchmark. I further document a large and systematic gap between theoretical AI exposure and observed AI usage by cross-referencing the ENE-M occupational distribution with publicly available data from the Anthropic Economic Index. The paper concludes that the current generation of AI exposure indices, while informative for advanced economies, requires substantive adaptation before it can guide labor market policy in countries with dual employment structures. These findings have implications for the measurement infrastructure underlying global assessments of AI's labor market impact, including those produced by the IMF, ILO, and World Bank.

**Keywords:** artificial intelligence, labor market exposure, informal employment, Côte d'Ivoire, occupational classification, Anthropic Economic Index

**JEL codes:** J46, O33, O15, O55, E26

---

## 1. Introduction

The rapid advance of large language models (LLMs) and other AI systems has prompted a surge of research on their potential impact on labor markets. A now-standard empirical approach consists of measuring the "exposure" of occupations to AI capabilities — that is, the share of tasks within an occupation that AI systems could, in principle, perform or substantially accelerate. The seminal contributions of Felten, Raj, and Seamans (2021), Eloundou et al. (2024), and Pizzinelli et al. (2023) have produced occupation-level exposure scores that are widely used in policy analysis by the IMF, World Bank, ILO, and OECD, among others.

However, these indices share a common empirical foundation: the O\*NET database maintained by the U.S. Bureau of Labor Statistics. O\*NET describes the task content of occupations as they are performed in the United States — a high-income, predominantly formal economy. When these indices are applied to other countries via crosswalks to the International Standard Classification of Occupations (ISCO-08), an implicit assumption is made: that a given ISCO code maps to roughly the same bundle of tasks regardless of the country or institutional context in which the occupation is performed. This assumption is unlikely to hold in economies where the dominant form of employment is informal.

This paper examines what happens when AI exposure indices are applied to a labor market where informal employment accounts for roughly 90 percent of total employment. Côte d'Ivoire provides an instructive case. Its Enquête Nationale sur l'Emploi auprès des Ménages (ENE-M) is a nationally representative panel survey coded at the 4-digit ISCO-08 level, with detailed information on employment formality, working conditions, and — critically — access to information and communication technologies (ICTs) in the workplace. These data make it possible not only to map standard AI exposure indices onto the Ivorian occupational distribution, but also to construct an informality-adjusted measure that accounts for the divergence between the theoretical and actual task content of occupations in the informal sector.

The paper makes three contributions. First, it provides the first AI exposure mapping for a francophone West African economy, extending the geographic coverage of the existing literature beyond the six countries analyzed by Pizzinelli et al. (2023), the 25 countries covered by Demombynes, Langbein, and Weber (2025), and the country-level analyses produced by the Anthropic Economic Index team. Second, it proposes a simple and replicable method for adjusting AI exposure indices to account for labor market informality, using ICT access as a proxy for the effective task content of informal occupations. This contribution is methodological: the adjustment can be applied to any country with a labor force survey that captures both ISCO codes and formality status. Third, it documents the gap between theoretical AI exposure and observed AI usage in Côte d'Ivoire by cross-referencing the ENE-M with the publicly available data from the Anthropic Economic Index, providing micro-level evidence on the barriers to AI diffusion in a low-income francophone context.

The paper proceeds as follows. Section 2 provides background on the Ivorian labor market and the ENE-M survey. Section 3 reviews the AI exposure literature and its application to developing countries. Section 4 describes the data and methodology. Section 5 presents results. Section 6 discusses implications, and Section 7 concludes.


## 2. Background: the Ivorian labor market

### 2.1 Structural features

Côte d'Ivoire is the largest economy in the West African Economic and Monetary Union (WAEMU), with a GDP per capita of approximately USD 2,600 (2023). Despite sustained economic growth averaging over 7 percent annually since 2012, the labor market remains characterized by several structural features that distinguish it sharply from the advanced economies on which AI exposure indices are calibrated.

The most salient feature is the predominance of informal employment. According to the ENE 2019 and subsequent rounds, approximately 89 to 93 percent of total employment is informal, depending on the definition used (enterprise-based vs. job-based, following the ILO 2023 guidelines from the 21st ICLS). The informal employment rate varies substantially by milieu de résidence — it is lower (though still dominant) in Abidjan's formal tertiary sector and approaches near-universality in rural areas. The ENSESI 2016 reported a composite labor underutilization indicator (SU4) of 27.8 percent, underscoring that the low headline unemployment rate (around 3 percent under the strict ILO SU1 definition) masks significant underemployment and labor market slack.

The occupational structure, coded under ISCO-08, is concentrated in three major groups: Group 5 (service and sales workers), Group 6 (skilled agricultural workers), and Group 9 (elementary occupations). Groups 1 through 3 — managers, professionals, and technicians — which are the most AI-exposed categories in high-income countries, account for a comparatively small share of total employment. This compositional difference alone would predict lower aggregate AI exposure in Côte d'Ivoire relative to advanced economies, a finding consistent with the cross-country pattern documented by Cazzaniga et al. (2024) and Pizzinelli et al. (2023).

A second distinguishing feature is the limited penetration of digital technologies in the workplace. While mobile phone ownership is near-universal, access to computers and the internet in a work context remains confined to a narrow segment of the formal sector. The EHCVM (Enquête Harmonisée sur les Conditions de Vie des Ménages) and the DATAFID survey on ICT access provide complementary data on this dimension. This digital access gap is not merely a constraint on AI adoption; it fundamentally alters the task content of occupations. A retail sales worker (ISCO 5221) in a digitized formal supermarket in Abidjan performs a substantively different set of tasks — involving point-of-sale systems, inventory management software, and potentially AI-assisted customer analytics — than a retail sales worker in an open-air market in Bouaké who conducts transactions entirely in cash, manages inventory through physical inspection, and relies on personal networks rather than digital platforms for supply chain management.

### 2.2 The ENE-M survey

The Enquête Nationale sur l'Emploi auprès des Ménages (ENE-M) is ANStat's flagship labor force survey, designed as a rotating panel with a 2-2-2 rotation scheme across 1,896 primary sampling units (zones de dénombrement) spanning all 33 administrative regions. The survey instrument is aligned with the CIST (Conférence Internationale des Statisticiens du Travail) resolutions and the ILO guidelines for labor force surveys, and produces the full suite of labor underutilization indicators from SU1 (strict unemployment) through SU4 (composite underutilization including time-related underemployment and the potential labor force).

For the purposes of this paper, the key variables are:

- **Occupation**: coded at the 4-digit ISCO-08 level, enabling direct linkage with AI exposure scores via the ISCO-SOC crosswalk
- **Employment formality status**: following the ILO/CIST criteria (enterprise registration, written contract, social security contributions), allowing decomposition of each occupational category into formal and informal segments
- **Sector of activity**: coded under ISIC Rev.4 (CITI Rev.4)
- **ICT access variables**: access to computer at work, internet use for work purposes, mobile phone use for professional activities
- **Standard demographic and human capital variables**: age, sex, education level, region, urban/rural

The rotating panel design allows, in principle, the observation of labor market transitions, although this paper focuses on the cross-sectional dimension for the exposure mapping exercise. The panel structure could be exploited in future work to study transitions between more and less AI-exposed occupations over time.


## 3. AI exposure indices: review and applicability to developing countries

### 3.1 The standard approach

The measurement of AI occupational exposure has converged around a common methodology: linking AI capabilities to the task content of occupations as described in the O\*NET database, then aggregating task-level exposure scores to the occupation level.

Felten, Raj, and Seamans (2021) introduced the AI Occupational Exposure (AIOE) index, which maps advances in specific AI application areas (image recognition, language modeling, etc.) to the abilities required by different occupations, as listed in O\*NET. The AIOE captures the breadth of AI capabilities relevant to each occupation.

Eloundou et al. (2024) developed the GPT exposure framework, which asks: for each Detailed Work Activity (DWA) in O\*NET, can a GPT-4-class LLM reduce the time required to complete the task by at least 50 percent, either directly (E1 exposure) or with access to complementary software tools (E2 exposure)? Using both human annotators and GPT-4 as classifiers, they produced occupation-level exposure scores ranging from 0 to 1. A key finding is that approximately 80 percent of U.S. workers have at least 10 percent of their tasks exposed, and about 19 percent have at least 50 percent of their tasks exposed.

Pizzinelli et al. (2023) extended the Felten et al. framework to six countries (US, UK, Brazil, Colombia, India, South Africa) using the ISCO-SOC crosswalk and worker-level microdata. Their innovation is the distinction between AI as a complement (augmenting worker productivity) and AI as a substitute (displacing worker labor), introducing a "high complementarity" and "low complementarity" decomposition of exposure. They find that advanced economies face higher unadjusted exposure than emerging markets, but that complementarity patterns — and therefore the implications for displacement risk — differ across country income levels.

### 3.2 Limitations for developing country application

Several limitations of the standard approach become apparent when it is applied beyond the OECD context.

**The O\*NET task content assumption.** O\*NET describes occupations as they are performed in the United States. The implicit assumption in cross-country applications via the ISCO-SOC crosswalk is that ISCO code X maps to the same task bundle worldwide. This assumption weakens as the institutional context diverges from the U.S. benchmark. In an economy with predominantly informal employment, the actual task content of many occupations differs markedly from the O\*NET description: tasks may be less digitized, less codified, more reliant on tacit knowledge and personal relationships, and less amenable to AI augmentation or substitution. Demombynes, Langbein, and Weber (2025) acknowledge this limitation but do not directly address it in their 25-country analysis.

**The infrastructure prerequisite.** AI exposure is, at best, a measure of technical feasibility — the extent to which an AI system *could* perform or assist with a task. But technical feasibility requires infrastructure: reliable electricity, internet connectivity, access to computing devices. In low-income countries, Demombynes et al. (2025) find that effective exposure is substantially lower than occupational exposure once electricity access is accounted for. This paper extends their approach by using workplace-level ICT access from the ENE-M as a more granular adjustment factor.

**The informality gap.** The most substantive limitation for countries like Côte d'Ivoire is the treatment of informal employment. Standard exposure indices assign the same score to all workers in a given occupation, regardless of whether they work in the formal or informal sector. Yet the task content of an ISCO 5221 (shop sales assistant) in a formal retail chain — where tasks include operating a computerized point-of-sale system, managing digital inventory, and processing electronic payments — is substantively different from the task content of an ISCO 5221 in an informal market stall — where tasks are entirely manual, transactions are in cash, and inventory management is visual. The former may be meaningfully exposed to AI-driven automation of checkout, inventory optimization, and customer analytics; the latter is not.

No existing paper has attempted to systematically adjust AI exposure indices for the formal/informal decomposition of occupations.

### 3.3 Observed usage vs. theoretical exposure

A parallel literature is emerging on the gap between what AI *could* do (exposure) and what AI *is actually used for* (diffusion). The Anthropic Economic Index, which analyzes millions of real-world conversations with Claude to identify the occupations and tasks for which AI is being used, provides the most granular available data on observed AI usage by occupation and country. The Index's reports have documented substantial variation in AI usage across countries, with advanced economies showing much higher per-capita adoption than developing economies. A recent IMF working paper by Handa et al. (2026) uses the Anthropic Economic Index data to construct an "AI concentration index" (ACI), finding that in developing economies, virtually all AI-generated economic value is concentrated in a small professional enclave (ACI near 1.0), compared to 0.4–0.5 in high-income economies.

This exposure-usage gap is a natural consequence of the factors described above: infrastructure constraints, the informality of employment, and — in the case of francophone Africa — a language barrier, since the dominant LLMs are trained primarily on English-language data. The Anthropic Economic Index January 2026 report notes that Claude performs different types of tasks in countries at different stages of economic development, suggesting that the nature, not just the volume, of AI usage differs across country income levels.


## 4. Data and methodology

### 4.1 Data sources

This paper combines five data sources:

**ENE-M micro-data.** [Specify the most recent available round: ENE 2024 or ENE-M panel wave.] The analysis uses the full sample of individuals aged 15 and above who are classified as employed (actifs occupés) under the CIST/ILO framework. Key variables are described in Section 2.2.

**AI exposure scores.** Three sets of occupation-level exposure scores are used:

1. The GPT exposure scores from Eloundou et al. (2024), available at the O\*NET SOC level from the authors' GitHub repository (file: `gptsRgpts_occ_lvl.csv`). These provide E1 (direct LLM exposure), E2 (LLM + software tools exposure), and a combined measure.
2. The AIOE index from Felten, Raj, and Seamans (2021), available from their data appendix (file: `AIOE_DataAppendix.xlsx`).
3. The complementarity-adjusted index from Pizzinelli et al. (2023), which distinguishes high-complementarity and low-complementarity (substitution-risk) exposure.

**ISCO-08 to SOC crosswalk.** The concordance table between 4-digit ISCO-08 codes and 6-digit SOC 2018 codes, sourced from the ILO and BLS crosswalk documentation. Because the mapping is many-to-many (one ISCO code can correspond to multiple SOC codes and vice versa), the merge procedure requires aggregation rules, described below.

**EHCVM 2021 (and/or DATAFID).** The Enquête Harmonisée sur les Conditions de Vie des Ménages provides supplementary data on household-level ICT access (computer ownership, internet access, mobile phone ownership) that complement the ENE-M's individual-level ICT variables for the informality adjustment.

**Anthropic Economic Index data.** Publicly available on Hugging Face, the Index provides occupation-level AI usage data (proportion of conversations coded to each O\*NET occupation, distinguishing augmentation vs. automation) and country-level usage intensity.

### 4.2 Crosswalk construction

The central methodological challenge is the linkage between the ISCO-08 codes used in the ENE-M and the SOC codes used in the O\*NET-based exposure scores. The crosswalk proceeds in three steps:

**Step 1: Direct concordance.** Using the official ILO/BLS crosswalk table, each 4-digit ISCO-08 code is matched to one or more 6-digit SOC codes. Where the mapping is one-to-one, the exposure score is directly assigned.

**Step 2: Aggregation for one-to-many matches.** Where one ISCO code maps to multiple SOC codes, the exposure score assigned to the ISCO code is the employment-weighted average of the constituent SOC scores, using U.S. employment weights from the BLS Occupational Employment and Wage Statistics (OEWS). This follows the convention in Pizzinelli et al. (2023) and Demombynes et al. (2025).

**Step 3: Handling unmatched codes.** Some ISCO codes used in the ENE-M may not have a clean match in the crosswalk — particularly occupations that are common in sub-Saharan Africa but have no direct U.S. equivalent (e.g., certain agricultural occupations, artisanal trades). These are handled through manual assignment based on task similarity, with a sensitivity analysis excluding unmatched occupations.

The quality of the crosswalk is assessed by reporting: (i) the share of ENE-M employment that is matched vs. unmatched, (ii) the coefficient of variation of exposure scores within each ISCO code (reflecting heterogeneity in the underlying SOC codes), and (iii) the results of the sensitivity analysis.

### 4.3 Standard exposure mapping

Once the crosswalk is constructed, each employed individual *i* in the ENE-M is assigned an exposure score *E_i* based on their 4-digit ISCO code. Aggregate exposure measures are then computed as follows.

**National aggregate exposure:**

$$\bar{E} = \sum_{i=1}^{N} w_i \cdot E_i$$

where *w_i* is the survey sampling weight, normalized to sum to 1.

**Exposure by subgroup.** The same weighted average is computed for subgroups defined by: region (Abidjan, other urban, rural), sex, age group, education level, sector of activity (ISIC section), and — crucially — formality status (formal vs. informal).

**Exposure distribution.** Following Eloundou et al. (2024), I report the share of workers with exposure above selected thresholds (10%, 25%, 50%, 75%) and the full density of the exposure distribution.

### 4.4 Informality-adjusted exposure

The core methodological contribution of this paper is the construction of an informality-adjusted exposure measure. The adjustment rests on the premise that the effective task content of an occupation in the informal sector diverges from the O\*NET benchmark in ways that reduce the applicability of AI tools.

**Adjustment factor.** For each individual *i*, define:

$$E_i^{adj} = E_i \times \delta_i$$

where *δ_i* ∈ [0, 1] is an adjustment factor that captures the extent to which individual *i*'s actual work environment enables the task content described in O\*NET.

Two specifications for *δ_i* are proposed:

**Specification A — Digital access proxy:**

$$\delta_i = \hat{P}(\text{digital access}_i \mid X_i)$$

where digital access is a binary variable indicating whether the individual uses a computer or the internet for work purposes, and *X_i* is a vector of controls including ISCO code, formality status, sector, region, and education. The predicted probability is estimated via a logit model on the ENE-M sample.

The intuition is simple: an individual whose work context involves no digital technology is unlikely to be effectively exposed to AI, regardless of what the O\*NET-based exposure score implies for their occupation. The logit model allows the adjustment to vary smoothly across the formal-informal spectrum and across occupations, rather than applying a binary formal/informal indicator.

**Specification B — Sector-formality interaction:**

$$\delta_i = \begin{cases} 1 & \text{if formal} \\ \alpha_s & \text{if informal, sector } s \end{cases}$$

where *α_s* is a sector-specific scaling factor calibrated from EHCVM data on ICT adoption rates among informal enterprises, by ISIC section. This specification is cruder but more transparent and does not require estimation.

**Comparison and robustness.** Both specifications are reported, and their implications compared. The adjusted aggregate exposure is:

$$\bar{E}^{adj} = \sum_{i=1}^{N} w_i \cdot E_i^{adj}$$

The difference Δ = *Ē* − *Ē^adj* is the "informality exposure gap" — the extent to which standard indices overstate effective AI exposure when informality is not accounted for.

**Planned extension — task-content verification and reconstruction.** Specifications A and B both treat the informality adjustment as a multiplicative discount applied on top of the US-calibrated O\*NET exposure score: they scale down *how much* of the assumed task bundle is effectively reachable, but they do not verify *whether* the assumed task bundle itself is the right one for a given occupation as practiced in Côte d'Ivoire. The ENE-M questionnaire offers a way to check this directly: variable EP1b captures each respondent's principal tasks and functions in free verbatim text, independently of the coded ISCO occupation (EP1b1). The planned extension compares this reported task content against the O\*NET task statements associated with the assigned SOC/ISCO code, for a sample of occupations where formal/informal task divergence is expected to be largest (e.g., ISCO groups 5 and 7, per Section 5.2.1). Where systematic divergence is found, this analysis will inform an adapted or reconstructed exposure score for the affected occupations, rather than relying solely on the uniform multiplicative adjustment. This task-content comparison must be conducted entirely on aggregated outputs (keyword/topic frequencies, not verbatim excerpts), consistent with the statistical confidentiality of individual ENE-M responses. Results, if conclusive, will be reported as a robustness check (Specification C) alongside A and B; if inconclusive given data constraints, the multiplicative adjustment (A/B) remains the paper's primary approach.

### 4.5 Exposure-usage gap analysis

The final analytical component cross-references the ENE-M-based exposure profile with the observed usage data from the Anthropic Economic Index.

**Procedure:**

1. From the Anthropic Economic Index data on Hugging Face, extract the distribution of Claude usage by O\*NET occupation, globally and for available country-level breakdowns
2. Construct a "usage profile" for Côte d'Ivoire: the predicted distribution of AI usage across occupations, given the country's occupational composition, under the assumption that usage rates by occupation are equal to the global average
3. Compare this predicted usage profile to (a) the actual (very low) observed usage from the Anthropic data and (b) the theoretical exposure profile from the indices
4. Decompose the gap into components attributable to: occupational structure (Côte d'Ivoire has fewer workers in high-usage occupations), infrastructure constraints, language barriers, and other factors

This decomposition is necessarily indicative rather than causal: the goal is to document the magnitude and structure of the gap, not to identify causal mechanisms. A Kitagawa-Blinder-Oaxaca-style decomposition is used to separate the "composition" effect (differences in occupational structure) from the "coefficient" effect (differences in within-occupation usage rates).


## 5. Results

### 5.1 Standard AI exposure of the Ivorian labor force

*[This section will present:]*

**5.1.1 Aggregate exposure.** National weighted-average exposure scores under each of the three indices (GPAI, AIOE, Pizzinelli complementarity-adjusted). Comparison with the six-country benchmarks from Pizzinelli et al. (2023) and the 25-country results from Demombynes et al. (2025).

*Expected finding:* Côte d'Ivoire's aggregate exposure is lower than all six countries in Pizzinelli et al., and comparable to the low-income country average in Demombynes et al. This is driven primarily by the occupational composition effect — the concentration of employment in ISCO groups 5, 6, and 9, which have lower exposure scores than groups 1–3.

**5.1.2 Distribution of exposure.** Histogram and cumulative distribution of individual-level exposure scores. Shares of workers above the 10%, 25%, and 50% exposure thresholds.

*Expected finding:* The distribution is strongly right-skewed, with a long left tail of near-zero exposure (agricultural workers, elementary occupations) and a thin right tail of high exposure (professionals, managers, technicians concentrated in Abidjan's formal sector).

**5.1.3 Exposure by subgroup.** Disaggregation by:

- **Region:** Abidjan vs. other urban vs. rural. Expected gradient: Abidjan highest, rural lowest.
- **Sex:** Following the pattern in Pizzinelli et al. and Cazzaniga et al., women may have *higher* exposure in the formal sector (concentration in clerical and service occupations), but lower exposure overall due to higher informal employment rates.
- **Education:** Strong positive gradient expected.
- **Age:** Younger workers in urban formal sector may have higher exposure; the pattern may be weaker or reversed in rural/informal settings.
- **Formality status:** Large gap expected — this previews the Section 5.2 results.

**Table 1:** Average AI exposure by ISCO-08 major group, Côte d'Ivoire vs. benchmark countries
**Figure 1:** Density plot of individual-level AI exposure, Côte d'Ivoire vs. South Africa (the closest emerging market benchmark)
**Figure 2:** Map of average AI exposure by region (33 regions)

### 5.2 The informality adjustment

**5.2.1 The formal-informal exposure gap within occupations.** Before applying the adjustment, I document the raw difference: for each ISCO code with sufficient observations in both the formal and informal sectors, I compare the distribution of ICT access variables. This establishes the empirical basis for the adjustment — i.e., that formal and informal workers in the same ISCO code do, in fact, have substantively different digital task environments.

*Expected finding:* For ISCO groups 5 (services/sales) and 7 (craft workers), which are the groups with the most variation in formality status, the ICT access gap between formal and informal workers is large (e.g., [XX]% of formal ISCO 5221 workers use a computer at work vs. [XX]% of informal ISCO 5221 workers).

**5.2.2 Logit model for digital access (Specification A).** Estimation results for the logit model predicting workplace digital access. Key coefficients: formality status, ISCO group, sector, region, education. Marginal effects at representative values.

*Expected finding:* Formality status is a strong and significant predictor of digital access, even after controlling for occupation and education. The predicted probability of digital access (δ̂_i) is near zero for most informal workers and substantively positive only for formal workers in ISCO groups 1–4 in Abidjan.

**5.2.3 Adjusted exposure results.** Comparison of unadjusted and adjusted aggregate exposure:

- National aggregate: Ē vs. Ē^adj under Specifications A and B
- Informality exposure gap: Δ = Ē − Ē^adj, expressed in absolute terms and as a percentage
- Subgroup decomposition: which groups see the largest adjustment? (Expected: rural informal workers, ISCO groups 5–9)

*Expected finding:* The adjustment reduces national aggregate exposure by [XX]–[XX] percent, depending on the specification. The adjustment is negligible for Abidjan's formal sector and massive for rural informal employment. The implication is that aggregate exposure figures that do not account for informality are misleading in the Ivorian context.

**Table 2:** Unadjusted vs. adjusted AI exposure by ISCO major group and formality status
**Figure 3:** National exposure distribution, unadjusted vs. adjusted (overlaid densities)
**Figure 4:** Regional map of the informality exposure gap (Δ by region)

### 5.3 The exposure-usage gap

**5.3.1 Observed AI usage in Côte d'Ivoire.** Using the Anthropic Economic Index (AEI) country-level release (`aei_enriched_claude_ai_2025-08-04_to_2025-08-11.csv`), Côte d'Ivoire clears the Index's minimum-observations privacy threshold (200 conversations), with 939 conversations recorded in the observation window — enough for country-level but not for reliable occupation-level breakdowns (see below). Côte d'Ivoire's usage-per-capita index — usage relative to what its share of world population would predict, with 1.0 denoting proportional usage — is 0.199, placing it in the lowest usage quartile ("Tier 1") alongside Nigeria (0.202), Senegal (0.295), and Ghana (0.348), and far below the United Kingdom (2.665) and United States (3.624). The automation/augmentation split for Côte d'Ivoire is 59.6 percent automation-oriented interactions (directive, feedback-loop patterns) versus 40.4 percent augmentation-oriented (validation, task-iteration, learning patterns) — a more automation-leaning split than is typically reported for high-income countries, consistent with the pattern documented by Handa et al. (2026). I have not yet reproduced Handa et al.'s AI Concentration Index (ACI) methodology directly; the SOC-occupation breakdown reported next provides a simpler, complementary signal of concentration.

At the occupation level, AEI data for Côte d'Ivoire is sparse: only two SOC major groups meet the minimum-observations threshold — Computer and Mathematical (24.6 percent of classified usage) and Educational Instruction and Library (1.8 percent) — with 73.6 percent of usage falling into "not_classified" (suppressed for insufficient granularity). The O\*NET tasks that do surface are dominated by software development activities (writing and modifying code, web development, troubleshooting) plus one non-technical task (assisting students with coursework). This is consistent with — though not on its own sufficient to establish — the "narrow professional enclave" pattern described by Handa et al. (2026): the visible slice of Ivorian Claude usage is concentrated in a thin, IT-adjacent segment of the labor force.

**5.3.2 Predicted vs. actual usage.** The Kitagawa-Blinder-Oaxaca decomposition proposed in Section 4.5 — separating the occupational-composition effect from the within-occupation usage gap — has not yet been implemented; it requires the full occupation-level usage profile merged against the ENE-M occupational distribution via the ISCO crosswalk, which is pending completion of the crosswalk's employment-weighting refinement (Section 4.2). The sparse occupation-level AEI coverage documented in 5.3.1 (73.6 percent not_classified) suggests the within-occupation component may be difficult to estimate precisely for Côte d'Ivoire specifically, and the decomposition may need to rely more heavily on the cross-country regularities documented in 5.3.3 than on Côte d'Ivoire-specific occupation cells.

**5.3.3 The language dimension.** Extracting all 48 Sub-Saharan and North African countries classified as Francophone, Anglophone, Lusophone, or Arabophone by dominant official language, 43 are present in the AEI data with non-zero usage. Descriptively, mean usage-per-capita index is 0.450 for Arabophone countries, 0.260 for Anglophone, 0.139 for Francophone, and 0.115 for Lusophone countries. Regressing the usage-per-capita index on log GDP per working-age capita and a Francophone indicator, restricted to the 33 Francophone and Anglophone countries, yields a positive and highly significant GDP coefficient (0.182, p<0.001) and a negative Francophone coefficient (−0.080, p=0.23, R²=0.42). The direction is consistent with the language-barrier hypothesis of Handa et al. (2026), but the coefficient is not statistically significant at conventional levels with this sample size (n=33), so this result should be read as suggestive rather than conclusive. Notably, Côte d'Ivoire's own usage-per-capita index (0.199) sits above the Francophone-country median (0.117), indicating it is not a particularly low-usage outlier within its linguistic peer group.

**Table 3:** AI usage metrics, Côte d'Ivoire vs. selected African and emerging-market benchmarks
**Figure 5:** Scatter plot of AI exposure (x-axis) vs. observed AI usage (y-axis) by occupation, Côte d'Ivoire vs. United States


## 6. Discussion

### 6.1 Implications for measurement

The results challenge the straightforward application of AI exposure indices to countries with dual labor markets. The informality adjustment proposed in this paper is simple, replicable, and data-driven — it requires only a labor force survey with ISCO codes, formality indicators, and ICT access variables, all of which are standard in modern labor force surveys in sub-Saharan Africa (including the harmonized surveys of the WAEMU zone). The key message for the measurement community — including the ILO, which maintains the ISCO classification, and the World Bank, which supports labor force survey harmonization — is that occupation-level AI exposure scores should be interpreted as upper bounds on effective exposure in economies with high informality, unless an informality adjustment is applied.

This finding speaks directly to the ongoing debate in the AI-and-labor literature about the gap between theoretical exposure and realized impact. Acemoglu (2024) has argued that the realized macroeconomic impact of AI will be substantially smaller than the exposure scores suggest, even in advanced economies, due to the cost and difficulty of implementing AI in real work contexts. The present paper extends this argument to developing economies, where the gap between theoretical exposure and effective exposure is amplified by a structural factor — labor market informality — that the existing literature has not addressed.

### 6.2 Implications for policy

For Ivorian policymakers, the results carry a dual message. On one hand, the low effective exposure of the bulk of the labor force suggests that the immediate labor market disruption from AI is likely to be modest — the vast majority of Ivorian workers perform tasks that AI systems cannot currently reach, both because of the nature of the tasks (manual, relational, context-dependent) and because of the absence of the digital infrastructure required for AI deployment. This contrasts with the more alarming headlines from global reports that emphasize the share of employment "exposed" to AI without adjusting for these contextual factors.

On the other hand, the concentration of effective AI exposure in a narrow formal-sector enclave — primarily in Abidjan's service, finance, and professional sectors — raises distributional concerns. If AI productivity gains accrue only to the formal sector, the already wide productivity gap between formal and informal employment could widen further, exacerbating labor market dualism. This is consistent with the finding from the Anthropic Economic Index that AI usage in developing economies is concentrated in a small professional enclave (Handa et al. 2026), and with the broader literature on technology-driven inequality in developing countries.

The policy implication is not that AI can be ignored in countries like Côte d'Ivoire, but that the relevant policy questions are different from those in advanced economies. Rather than asking "how do we retrain workers displaced by AI?", the more pertinent questions are: (i) how can the productivity benefits of AI be extended beyond the formal-sector enclave? (ii) what infrastructure investments (electricity, connectivity, digital literacy) are prerequisites for broader AI diffusion? and (iii) how should educational systems prepare for a labor market where the digital-informal divide may become the dominant axis of inequality?

### 6.3 Connection to the Anthropic Economic Index research agenda

The Anthropic Economic Index team has explicitly called for geographic extension of their measurement infrastructure, including the creation of Regional Research Economist positions to develop country-specific analyses. The present paper demonstrates the value of combining the Index's observed-usage data with national labor force survey microdata — a combination that produces insights neither data source can deliver alone. The exposure-usage gap analysis in Section 5.3 illustrates the kind of research that could be scaled across the 150+ countries for which the Index collects data, provided that national statistical offices make their labor force survey microdata available for linkage.

For francophone Africa specifically, this paper highlights a research agenda that is currently underserved: understanding how AI diffuses in economies where the dominant employment form is informal, the dominant language is not English, and the dominant infrastructure constraints are not bandwidth but electricity and device access.

### 6.4 Limitations

Several limitations should be noted. First, the exposure indices used in this paper were developed to measure the capabilities of GPT-4-class models as of 2023–2024. AI capabilities are advancing rapidly, and exposure measures will need to be updated as models become more capable, multilingual, and multimodal. Second, the informality adjustment relies on ICT access as a proxy for effective task content, which is an imperfect measure — some informal workers may perform AI-exposed tasks without digital tools (e.g., translation, data analysis with pen and paper), and some formal workers with digital access may not use AI even if their tasks are theoretically exposed. Third, the Anthropic Economic Index data for Côte d'Ivoire may be too sparse to support robust occupation-level comparisons; the cross-country analysis in Section 5.3 serves as a complement when country-specific data are insufficient. Fourth, the paper is descriptive rather than causal: it documents patterns of exposure and usage, but does not identify causal effects of AI on employment, wages, or productivity in the Ivorian context. Such causal analysis would require either experimental variation in AI access or quasi-experimental identification strategies, which are left for future work.


## 7. Conclusion

This paper provides the first systematic analysis of AI occupational exposure in a francophone West African economy. Using micro-data from Côte d'Ivoire's ENE-M, I show that standard AI exposure indices, when applied without adjustment, overstate the effective exposure of the Ivorian labor force by failing to account for the dominance of informal employment. The informality-adjusted measure proposed here reduces aggregate exposure by [XX] percent and reveals a sharply dual pattern: a thin formal-sector enclave in Abidjan with exposure levels comparable to emerging-market benchmarks, and a vast informal labor force with near-zero effective exposure.

The gap between theoretical exposure and observed AI usage, documented using the Anthropic Economic Index, further underscores the distance between what AI *could* do and what AI *is doing* in the Ivorian economy. The combination of occupational composition, informality, infrastructure constraints, and the francophone language barrier creates a multi-layered filter that substantially dampens the effective impact of current AI systems on the Ivorian labor market.

These findings contribute to a growing body of evidence that the labor market impact of AI will be uneven across countries, shaped not only by occupational structure but also by institutional features — particularly labor market formality — that the current generation of exposure indices does not capture. The informality adjustment proposed here is a first step toward more context-appropriate measurement. As AI capabilities advance and diffuse more broadly, repeated application of this framework to successive rounds of the ENE-M panel will allow monitoring of how effective AI exposure evolves over time in a dual labor market — a question that is both empirically novel and policy-relevant.

---

## References

Acemoglu, D. (2024). The simple macroeconomics of AI. *NBER Working Paper* No. 32487.

Acemoglu, D., Autor, D., Hazell, J., & Restrepo, P. (2025). Artificial intelligence and the labor market. *NBER Working Paper* No. 33509.

AfDB. (2025). *Africa's AI productivity gain: Pathways to labour efficiency, economic growth and inclusive transformation.* African Development Bank.

Anthropic. (2025). Anthropic Economic Index report: Uneven geographic and enterprise AI adoption.

Anthropic. (2026a). Anthropic Economic Index report: Economic primitives.

Anthropic. (2026b). Anthropic Economic Index report: Cadences.

Cazzaniga, M., Jaumotte, F., Li, L., Pizzinelli, C., Panton, A., Tavares, M. M., & Rockall, I. (2024). Gen-AI: Artificial intelligence and the future of work. *IMF Staff Discussion Note* SDN/2024/001.

Demombynes, G., Langbein, J., & Weber, M. (2025). The exposure of workers to artificial intelligence in low- and middle-income countries. *World Bank Policy Research Working Paper* No. 11057.

Eloundou, T., Manning, S., Mishkin, P., & Rock, D. (2024). GPTs are GPTs: Labor market impact potential of large language models. *Science*, 384(6702), 1306–1308.

Felten, E., Raj, M., & Seamans, R. (2021). Occupational, industry, and geographic exposure to artificial intelligence: A novel dataset and its potential uses. *Strategic Management Journal*, 42(12), 2195–2217.

Gmyrek, P., Berg, J., Kamiński, K., et al. (2025). Generative AI and jobs: A refined global index of occupational exposure. *ILO Working Paper* No. 140.

Handa, K., et al. (2026). Aggregate gains from AI and their distribution: Global evidence from usage data. *IMF Working Paper*.

ILO. (2023). Resolution concerning statistics of the informal economy. 21st International Conference of Labour Statisticians.

IMF. (2026). Unlocking the potential: AI in sub-Saharan Africa. *Departmental Paper* No. 2026/013.

Pizzinelli, C., Panton, A., Tavares, M. M., Cazzaniga, M., & Li, L. (2023). Labor market exposure to AI: Cross-country differences and distributional implications. *IMF Working Paper* No. 23/216.

---

## Appendix A: ISCO-08 to SOC 2018 crosswalk details

*[To be completed: full concordance table, match rates, handling of unmatched codes]*

## Appendix B: Exposure scores by 2-digit ISCO-08

*[To be completed: table of GPAI, AIOE, and Pizzinelli scores for each 2-digit ISCO group, with ENE-M employment shares]*

## Appendix C: Regional exposure maps

*[To be completed: choropleth maps of exposure by region, unadjusted and adjusted]*

## Appendix D: Sensitivity analysis

*[To be completed: results with (i) alternative crosswalk assumptions, (ii) exclusion of unmatched occupations, (iii) alternative informality adjustment specifications]*
