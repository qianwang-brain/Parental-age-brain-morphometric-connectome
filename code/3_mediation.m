% Script: 3_mediation.m
%
% Purpose:
%   To examine whether children’s brain morphometric connectome mediates
%   the association between parental age and cognition/psychiatic/behavior outcomes.
%
% Description:
%   - Loads individualized cognitive summary scores and morphometric
%     connectome measures (node similarity strength / system-level modules).
%   - Selects modules showing significant parental-age effects based on
%     prior modeling results.
%   - Performs site harmonization using ComBat to control batch effects.
%   - Regresses out demographic and perinatal covariates (e.g., sex, race,
%     socioeconomic status, preterm birth) from all variables.
%   - Conducts mediation analysis using bootstrapping
%     (10,000 samples with confidence interval estimation).
%   - Identifies significant mediation paths and applies FDR correction
%     across modules for multiple comparison control.
%   - Outputs mediation statistics for downstream visualization and reporting.

% Reference:
%   Wang et al., "Extreme parental age shapes brain morphometric connectome, 
%   neurocognitive and psychiatric traits in preadolescents"
% ================================================================



clc;clear
addpath 'E:\E\matlab_2020\toolbox\toolbox_qianwang\MediationToolbox-master\MediationToolbox-master\mediation_toolbox'
addpath('E:\E\matlab_2020\bin\parental_age_official\Jfortin1')

%cog_y
load 'C:\Program Files\MATLAB\R2020b\bin\ABCD_MSN\5_Score\Mediation\0_Selection\M\variable_cog.mat' 
cog=cog(:,10);%%summary score

%%M(Edge or Node)
load 'C:\Program Files\MATLAB\R2020b\bin\ABCD_MSN\3_MSN_Construct\results_M\module.mat'
edge(cog_del,:)=[]; 

%sig M
load 'C:\Program Files\MATLAB\R2020b\bin\ABCD_MSN\4_LMM\results_m\results_module_m.mat'
clear con con_m net_name signame

%peaks
load 'C:\Program Files\MATLAB\R2020b\bin\ABCD_MSN\4_LMM\results_m\peaks_m_module.mat'
clear posi x1 yfit_c


med={};
for j=1:length(index)
    
    sig_index=index(j);
    %%sort
%       dd=find(X<a(j,1));
      dd=find(X>a(j,1));
    
    %cogavioral problems
    c1=c(dd,:);
    X1=X(dd,:);
    edge1=edge(dd,:); %Need to define new edge1 cog1  site
    cog1=cog(dd,:);
    
    sex=c1(:,2);
    sex1=dummyvar(sex);
    
    sta=c1(:,9);
    sta1=dummyvar(sta);
    
    race=c1(:,6);
    race1=dummyvar(race);
    
    preterm=c1(:,8);
    site=c1(:,3);
    
    mod=[X1,c1(:,4:5),c1(:,1),c1(:,7),preterm,sex1(:,2),sta1(:,2),race1(:,2:end),cog1];
    %delete site
    
    try
        data_harmonized_M= combat(edge1',site,mod,1);
    catch
        warning('Error: The expression to the left of the equals sign is not a valid target for an assignment.');
        [unique_values, ~, index111] = unique(site);
        unique_indices = find(histcounts(index111) == 1);
        site_del_ind = find(ismember(index111, unique_indices));%find site==1(people)
        %delete
        edge1(site_del_ind,:)=[];
        site(site_del_ind,:)=[];
        mod(site_del_ind,:)=[];
        data_harmonized_M= combat(edge1',site,mod,1);
        cog1(site_del_ind,:)=[];
    end
    
    
    %%MATLAB  mediation
    cov_final=mod(:,2:end-1);
    
    data_harmonized_M=data_harmonized_M';
    
    M_data = data_harmonized_M(:,sig_index);
    X_data=mod(:,1);
    Y_data = cog1;
    
    b = regress(X_data,[cov_final ones(size(cov_final,1),1)]);
    X_final = X_data - (b(1:end-1)'*cov_final')';
    
    b = regress(M_data,[cov_final ones(size(cov_final,1),1)]);
    M_final = M_data - (b(1:end-1)'*cov_final')';
    
    b = regress(Y_data,[cov_final ones(size(cov_final,1),1)]);
    Y_final = Y_data - (b(1:end-1)'*cov_final')';
    
    Y_final = zscore(Y_final);
    M_final = zscore(M_final);
    X_final = zscore(X_final);
    
    [paths_mean1, stats_mean1] = mediation(X_final,Y_final,M_final,'boottop','bootsamples',10000,'doCIs');
    [paths_mean2, stats_mean2] = mediation(X_final,Y_final,M_final);
    med{j}=stats_mean1.p;
    save ('cog_m_module.mat','med');
end


 %%Pick results   p<0.05
 index_sig=zeros(size(med));
 for i=1:size(med,1)
     for j=1:size(med,2)
         ab=med{i,j};
         ab([3])=[];
         if(all(ab<0.05))
             index_sig(i,j)=1;
         end
     end
 end
 
find(index_sig==1)

save ('C:\Program Files\MATLAB\R2020b\bin\ABCD_MSN\5_Score\Mediation\2_Mediation\Sig_coe\cog_m_module.mat','paths_mean1','stats_mean1','paths_mean2','stats_mean2','j')



%%Then FDR correction
clc;clear
load cog_m_module.mat
c=[];

for i =1:length(med)
   c(i,:)=med{i};
end

p_corr={};
for j=1:size(c,2)
    p_max=gretna_FDR(c(:,j),0.05);
    index=find(c(:,j)<=p_max);
    p_corr=[p_corr,index];
end




