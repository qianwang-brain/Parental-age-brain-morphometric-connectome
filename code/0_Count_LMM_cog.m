%% ================================================================
% Script: 0_Count_LMM_cog.m
%
% Purpose:
%   To assess parental-age–related changes in children's cognition,
%   psychiatric, and behavioral scores.
%
% Description:
%   - Loads individualized cognition, psychiatric, and behavioral scores.
%   - Estimates the effect of parental age on children's cognition,
%     psychiatric, and behavioral scores.
%   - The parental-age effect is derived from either linear or quadratic
%     models, depending on model selection criteria.

% Reference:
%   Wang et al., "Extreme parental age shapes brain morphometric connectome, 
%   neurocognitive and psychiatric traits in preadolescents"
% ================================================================


clc;clear
load 'C:\Program Files\MATLAB\R2020b\bin\ABCD_MSN\5_Score\Mediation\0_Selection\M\variable_cog2.mat'
sex=categorical(c(:,2));
preterm=categorical(c(:,8));
status=categorical(c(:,9));
race=categorical(c(:,6));
tb1=table(X,c(:,1),sex,preterm,c(:,7),status,race,c(:,5),c(:,4),'VariableNames',{'age_m','child_age','sex','preterm','BMI','status','race','income','education'});
save('mixed_model.mat','tb1');

clc;clear
load 'C:\Program Files\MATLAB\R2020b\bin\ABCD_MSN\5_Score\Mediation\0_Selection\M\variable_cog2.mat'
con=[];
for i=1:size(cog,2)
    y=cog(:,i);
    [age_pValue,age_beta,model_type,age_tStat]=mixed_model_cog(y);  
    con(i,1)=age_pValue;con(i,2)=age_beta;con(i,3)=model_type;con(i,4)=age_tStat;
end
p_max=gretna_FDR(con(:,1),0.05);
index=find(con(:,1)<=p_max);
con_m=con(index,:);

cog_name={'Picture Vocabulary Test Score';'Flanker Inhibitory Control and Attention Test Score';'List Sorting Working Memory Score';'Dimensional Change Card Sort Test Score';'Pattern Comparison Processing Speed Test Score';'Picture Sequence Memory Test Score';'Oral Reading Recognition Test Score';'Cognition Fluid Composite Score';'Crystallized Composite Score';'Cognition Total Composite Score'};
signame=cog_name(index);
save('result_m_cog','con_m','index','con','signame');

