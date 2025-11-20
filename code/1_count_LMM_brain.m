% Script: 1_count_LMM_brain.m
%
% Purpose:
%   To assess parental-age–related changes in children's brain morphometric connectome,

% Description:
%   - Loads individualized brain morphometric connectome: node similarity
%   strength/system-level connectome matrix.
%   - Estimates the effect of parental age on children's brain morphometric
%   connectome.
%   - The parental-age effect is derived from either linear or quadratic
%     models, depending on model selection criteria.

% Reference:
%   Wang et al., "Extreme parental age shapes brain morphometric connectome, 
%   neurocognitive and psychiatric traits in preadolescents"
% ================================================================


clc;clear
load C:\Program Files\MATLAB\R2020b\bin\2_Data_Selection\0_XC_Data\M\xc.mat
sex=categorical(c(:,2));
preterm=categorical(c(:,8));
status=categorical(c(:,9));
race=categorical(c(:,6));
site=categorical(c(:,3));

tb1=table(X,c(:,1),sex,preterm,c(:,7),status,site,race,c(:,5),c(:,4),'VariableNames',{'age_m','child_age','sex','preterm','BMI','status','site','race','income','education'});
save('mixed_model.mat','tb1');

%LMM
clc;clear
load C:\Program Files\MATLAB\R2020b\bin\3_MSN_Construct\results_M\module.mat
con=[];
for i=1:size(edge,2)
    y=edge(:,i);
    [age_pValue,age_beta,model_type,age_tStat]=mixed_model_brain(y);  
    con(i,1)=age_pValue;con(i,2)=age_beta;con(i,3)=model_type;con(i,4)=age_tStat;
end
p_max=gretna_FDR(con(:,1),0.05);
index=find(con(:,1)<=p_max);
con_m=con(index,:) 

%net_name
[m,n]=find(tril(ones(7)));
index_name=[m,n];
eco7={'PM';'AC1';'AC2';'SS';'PS';'LB';'IC'};

ind1=index_name(index,:);
net_name={};
for i=1:size(ind1,1)
    net_name{i,1}=eco7(ind1(i,1));
    net_name{i,2}=eco7(ind1(i,2));
end

save('results_module.mat','con_m','index','con','net_name')





