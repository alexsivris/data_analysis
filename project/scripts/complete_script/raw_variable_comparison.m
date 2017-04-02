clc, clear all, close all;
%% load data
load Y
load X_Agriculture
load X_Finance
load X_Health
load X_SocialDev

FONTSIZE = 15;
%% clear data
X_merge = [X_Health X_SocialDev X_Agriculture X_Finance];
X = table2array(X_merge);
Y = table2array(Y_new);

% discard features if it miss more than 40 countries
discard_feature = [];
for i = 1:size(X,2)
    col = X(:,i);
    nannum = length(find(isnan(col)));
    if nannum >40
        discard_feature = [discard_feature i];
    end
end
LIST_discard_feature = X_merge.Properties.VariableNames(discard_feature)';
X(:,discard_feature) = [];
X_merge(:,discard_feature) = [];

% discard countries if it miss more than 30 features
discard_country = [];
for i = 1:size(X,1)
    row = X(i,:);
    nannum = length(find(isnan(row)));
    if nannum >30
        discard_country = [discard_country i];
    end
end
LIST_discard_country = X_merge.Properties.RowNames(discard_country)';
X(discard_country,:) = [];
X_merge(discard_country,:) = []; X_merge_org = X_merge;
Y(discard_country) = [];

% replace nan with mean
Mean = mean(X,'omitnan');
% Determine addresses of missing values
Index = find(isnan(X));
[i,k] = find(isnan(X));
% Replace missing values by column means
X(Index) = Mean(k);

% %  standardization 
% X = zscore(X); X_org = X;
% [n,p] = size(X);

%%  varialbe v.s. Y

figure, 
    p = polyfit(X(:,12),Y, 2);
    plot(X(:,12),Y,'*',sort(X(:,12)),polyval(p,sort(X(:,12))));
    xlabel('Life expectancy at birth '); ylabel('Happieness Index'); hold on
    title('Happieness Index v.s. Life expectancy at birth ')
    set(gca,'FontSize',FONTSIZE);
    
figure, 
    p = polyfit(X(:,28),Y, 2);
    plot(X(:,28),Y,'*',sort(X(:,28)),polyval(p,sort(X(:,28))));
    xlabel('internet users per 100'); ylabel('Happieness Index'); hold on
    title('Happieness Index v.s. internet users per 100')    
    set(gca,'FontSize',FONTSIZE);
    
x = 54;
figure, 
    p = polyfit(X(:,x),Y, 2);
    plot(X(:,x),Y,'*',sort(X(:,x)),polyval(p,sort(X(:,x))));
    xlabel('access to non solid fuel'); ylabel('Happieness Index'); hold on
    title('Happieness Index v.s. access to non solid fuel')
    set(gca,'FontSize',FONTSIZE);

x = 21;
figure, 
    p = polyfit(X(:,x),Y, 2);
    plot(X(:,x),Y,'*',sort(X(:,x)),polyval(p,sort(X(:,x))));
    xlabel('Obesity rate'); ylabel('Happieness Index'); hold on
    title('Happieness Index v.s. Obesity rate')
    set(gca,'FontSize',FONTSIZE);
    
x = 62;
figure, 
%     p = polyfit(X(:,x),Y, 2);
    plot(X(:,x),Y,'*');
    xlabel('GDP growth'); ylabel('Happieness Index'); hold on
    title('Happieness Index v.s. GDP growth')
    set(gca,'FontSize',FONTSIZE);
    
x = 18;
figure, 
    p = polyfit(X(:,x),Y, 2);
    plot(X(:,x),Y,'*',sort(X(:,x)),polyval(p,sort(X(:,x))));
    xlabel('Adult mortality'); ylabel('Happieness Index'); hold on
    title('Happieness Index v.s. Adult mortality')
    set(gca,'FontSize',FONTSIZE);
      
x = 17;
figure, 
    p = polyfit(X(:,x),Y, 2);
    plot(X(:,x),Y,'*',sort(X(:,x)),polyval(p,sort(X(:,x))));
    xlabel('Urban population'); ylabel('Happieness Index'); hold on
    title('Happieness Index v.s. Urban population')
    set(gca,'FontSize',FONTSIZE);

%% varialbe v.s. variable
a = 18; b = 12;
figure, 
    p = polyfit(X(:,a),X(:,b), 2);
    plot(X(:,a),X(:,b),'*',sort(X(:,a)),polyval(p,sort(X(:,a))));
    xlabel('Urban population'); ylabel('Life expectancy at birth'); hold on
    title('Urban population v.s. Life expectancy at birth')    
    set(gca,'FontSize',FONTSIZE);
    
a = 36; b = 37;
figure, 
    p = polyfit(X(:,a),X(:,b), 2);
    plot(X(:,a),X(:,b),'*',sort(X(:,a)),polyval(p,sort(X(:,a))));
    xlabel('unemployment fem'); ylabel('unemployment male'); hold on
    title('unemployment fem v.s. unemployment male')        
    set(gca,'FontSize',FONTSIZE);
    
a = 4; b = 1;
figure, 
    p = polyfit(X(:,a),X(:,b), 2);
    plot(X(:,a),X(:,b),'*',sort(X(:,a)),polyval(p,sort(X(:,a))));
    xlabel('Fertility rate'); ylabel('Age dependency ratio'); hold on
    title('Fertility rate v.s. Age dependency ratio')          
    set(gca,'FontSize',FONTSIZE);  