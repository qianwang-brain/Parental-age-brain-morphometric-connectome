% Script: 2_Count_peaks.m
%
% Purpose:
%   To identify the turning point (peak)
%
% Description:
%   - Loads individualized morphometric connectome measures, including
%     node similarity strength and system-level connectivity indices.
%   - Fits the parental-age–connectome association using a quadratic model.
%   - Extracts the estimated turning point .
%   - Computes confidence intervals for the turning point based on the
%     fitted model parameters
%   - Outputs peak locations and confidence intervals for downstream
%     statistical analysis and visualization.

% Reference:
%   Wang et al., "Extreme parental age shapes brain morphometric connectome, 
%   neurocognitive and psychiatric traits in preadolescents"
% ================================================================

clc;clear
load E:\ABCD_MSN\2_Data_Selection\0_XC_Data\M\xc.mat
sex=categorical(c(:,2));
preterm=categorical(c(:,8));
status=categorical(c(:,9));
race=categorical(c(:,6));
site=categorical(c(:,3));

tb1=table(X,c(:,1),sex,preterm,c(:,7),status,site,race,c(:,5),c(:,4),'VariableNames',{'age_m','child_age','sex','preterm','BMI','status','site','race','income','education'});
save('mixed_model.mat','tb1');

%%--------cortical
clc;clear
load E:\ABCD_MSN\4_LMM\results_m\results_module.mat
load mixed_model.mat
y_plot=[];
for i=1:length(index)
    y=edge(:,index(i));
    tb1.depen_var= y;
    lme2 = fitlme(tb1,'depen_var ~ 1 + age_m^2 + child_age + sex + preterm + BMI + status + race + income + education + (1|site)+ (-1 + age_m|site) + (-1 - age_m+ age_m^2|site)'); 
    R = residuals(lme2); 
    f=lme2.Coefficients.Estimate(2)*tb1.age_m+lme2.Coefficients.Estimate(end)*(tb1.age_m.^2)+lme2.Coefficients.Estimate(1)+R;    
    y_plot=[y_plot,f];
end


% % y_plot=x+b+r   fit again
a=[];posi=[];yfit_c=[];
for j=1:size(y_plot,2)
    x=tb1.age_m;
    [p,s]= polyfit(x,y_plot(:,j),2);
    %extreme points
    x1=[15:0.0001:45]';%M
    y1=polyval(p,x1);
    [~,loc1] = findpeaks(-y1);
    [~,loc2] = findpeaks(y1);

    %confidence
    [yfit, dy] = polyconf(p, x1, s ,'predopt', 'curve');
    yfit_c=[yfit_c,yfit];
    Border = [yfit-dy, yfit+dy];

    [~,loc3] = findpeaks(-Border(:,1));
    [~,loc4] = findpeaks(Border(:,1));

    [~,loc5] = findpeaks(-Border(:,2));
    [~,loc6] = findpeaks(Border(:,2));

    %save
    if isempty(loc1)
        a(j,1)=x1(loc2);
        a(j,2)=x1(loc4);
        a(j,3)=x1(loc6);
        posi(j,1)=loc2;
        posi(j,2)=loc4;
        posi(j,3)=loc6;
    else
        a(j,1)=x1(loc1);
        a(j,2)=x1(loc3);
        a(j,3)=x1(loc5);
        posi(j,1)=loc1;
        posi(j,2)=loc3;
        posi(j,3)=loc5;
    end
end
a
posi

save('peaks_module.mat','a','posi','x1','yfit_c');


