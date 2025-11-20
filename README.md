# Extreme parental age shapes brain morphometric connectome, neurocognitive and psychiatric traits in preadolescents
E-mail: qianwang_bnu@mail.bnu.edu.cn


This repository provides Code for statistical modeling and mediation analysis that support the findings of the article entitled "Extreme parental age shapes brain morphometric connectome, neurocognitive and psychiatric traits in preadolescents"

## Code
0_Count_LMM_cog.m
Linear modeling assessing parental-age effects on children’s behavioral/cognitive summary scores.

1_count_LMM_brain.m
Mixed-effect modeling evaluating parental-age effects on morphometric similarity network (MSN) measures with site as random intercept.

2_Count_peaks.m
Estimation of quadratic turning points (peak/valley) in MSN–parental age associations, with confidence interval calculation.

3_mediation.m 
Bootstrapped mediation analysis testing whether MSN measures mediate the link between parental age and children's cognition.

mixed_model_brain.m
Generalized mixed-model fitting functions for MSN metrics.

mixed_model_cog.m
Supporting regression functions for behavioral/cognitive outcomes.
    
## Results
LMM_module_f.mat
Summary statistics of significant parternal age effects on node similarity strength/system-level connectome matrix obtained from mixed-effect modeling.

Mediation_beh_f_module.mat
Bootstrapped mediation results linking paternal age → MSN → cognition, including FDR-corrected significance indicators.

peaks_f_module.mat
Estimated turning point (peak age) and confidence interval for parternal-age effects on system-level connectome matrix.


## Analysis Overview

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

## 🔒 Data Availability Statement

The analyses were conducted on the ABCD dataset, which requires data use agreement (DUA) through the NIH NDA system.

Due to data privacy policies, individual-level data cannot be shared.
To support reproducibility, this repository includes:

✔ Analysis scripts
✔ Demonstration output files
✔ Full input format and variable requirements described in each script

Researchers with ABCD access can fully reproduce the results
following the scripts and processing steps.
