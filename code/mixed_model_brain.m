function [age_pValue,age_beta,model_type,age_tStat] = mixed_model_new(prediction)
% input:
%prediction: Dependent Variable
%Covariance_path: Covariance table path

 load('C:\Program Files\MATLAB\R2020b\bin\ABCD_MSN\4_LMM\mixed_model.mat');
 tb1.depen_var= prediction;

 lme1 = fitlme(tb1,'depen_var ~ 1 + age_m + child_age + sex + preterm +BMI + status + race + income + education + (1|site)+(-1 + age_m|site)');
 lme2 = fitlme(tb1,'depen_var ~ 1 + age_m^2 + child_age + sex + preterm + BMI + status + race + income + education + (1|site)+ (-1 + age_m|site) + (-1 - age_m+ age_m^2|site)');
  
    %AIC selecte age model
    if  lme2.ModelCriterion.AIC > lme1.ModelCriterion.AIC
        model_type = 1;
        age_pValue = lme1.Coefficients.pValue(2);
        age_beta = lme1.Coefficients.Estimate(2);
        age_tStat = lme1.Coefficients.tStat(2);
    else
        model_type = 2;
        age_pValue = lme2.Coefficients.pValue(end);    %significance age^2
        age_beta = lme2.Coefficients.Estimate(end);
        age_tStat = lme2.Coefficients.tStat(end);
    end
end

