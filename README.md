Extreme parental age shapes brain morphometric connectome, neurocognitive and psychiatric traits in preadolescents
E-mail: qianwang_bnu@mail.bnu.edu.cn


This repository provides Code for statistical modeling and mediation analysis that support the findings of the article entitled "Extreme parental age shapes brain morphometric connectome, neurocognitive and psychiatric traits in preadolescents"


📁 Repository Structure
MSN_github
│
├── code/                # Main analysis scripts
│   ├── 0_Count_LMM_cog.m
│   ├── 1_count_LMM_brain.m
│   ├── 2_Count_peaks.m
│   ├── 3_mediation.m
│   ├── mixed_model_brain.m
│   └── mixed_model_cog.m
│
└── results/             # Outputs for demonstration purpose only
    ├── LMM_module_f.mat
    ├── Mediation_beh_f_module.mat
    └── peaks_f_module.mat

🔍 Analysis Overview

1️⃣ Linear Modeling ofBehavior Scores
Evaluate parental-age–related changes in children's behavioral/cognitive scores.

2️⃣ Mixed-Effect Modeling for Brain Connectome
Assess parental age effects on morphometric similarity network measures
including node similarity and system-level connectivity.
(Linear mixed model with site as random intercept.)

3️⃣ Turning Point (Peak) Estimation
Identify the age at which parental age effect reaches a peak/valley
based on quadratic model fitting with confidence interval estimation.

4️⃣ Mediation Analysis
Test whether brain morphometric connectivity mediates
the link between parental age and cognition
(bootstrap mediation, 10,000 samples + FDR correction)

🔒 Data Availability Statement

The analyses were conducted on the ABCD dataset, which requires data use agreement (DUA) through the NIH NDA system.

Due to data privacy policies, individual-level data cannot be shared.
To support reproducibility, this repository includes:

✔ Analysis scripts
✔ Demonstration output files
✔ Full input format and variable requirements described in each script

Researchers with ABCD access can fully reproduce the results
following the scripts and processing steps.
