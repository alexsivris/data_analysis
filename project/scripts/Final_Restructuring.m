clc, clear all, close all;
%% load data

load Y
load X_Agriculture_not_normalized_correct
load X_Finance
load X_Health
load X_SocialDev_normalized


%% clear data
% discard the data which has not been normalized
X_Agriculture(:,[4 6 7 9 10 12]) = [];
X_SocialDev(:,[25 26]) = [];
X_Finance(:,7) = [];

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
X(discard_country,:) = [];
X_merge(discard_country,:) = [];
Y(discard_country) = [];
% replace nan with mean
Mean = mean(X,'omitnan');
% Determine addresses of missing values
Index = find(isnan(X));
[i,k] = find(isnan(X));
% Replace missing values by column means
X(Index) = Mean(k);



%% cluster
%cluster Y
figure, histogram(Y,[2.9:0.1:7.6]);
xlabel('Happieness Index'); ylabel('# of countries');
k = 3;
[idx,C] = kmeans(Y,k) ;
figure,  
for i = 1:k
    edges = [round(C(i))-2 :0.1:round(C(i))+2]; 
    histogram(Y(find(idx==i)),edges);hold on;
end
xlabel('Happieness Index'); ylabel('# of countries');

% cluster X

%% raw data comparision
% Happieness Index v.s. Life_expectancy_at_birth 
figure, 
    p = polyfit(X(:,12),Y, 2);
    plot(X(:,12),Y,'*',sort(X(:,12)),polyval(p,sort(X(:,12))));
    xlabel('Life expectancy at birth '); ylabel('Happieness Index'); hold on
    title('Happieness Index v.s. Life expectancy at birth ')
    
figure, 
    p = polyfit(X(:,30),Y, 2);
    plot(X(:,30),Y,'*',sort(X(:,30)),polyval(p,sort(X(:,30))));
    xlabel('internet users per 100'); ylabel('Happieness Index'); hold on
    title('Happieness Index v.s. internet users per 100')    
    
x = 54;
figure, 
    p = polyfit(X(:,x),Y, 2);
    plot(X(:,x),Y,'*',sort(X(:,x)),polyval(p,sort(X(:,x))));
    xlabel('access to non solid fuel'); ylabel('Happieness Index'); hold on
    title('Happieness Index v.s. access to non solid fuel')    

x = 22;
figure, 
    p = polyfit(X(:,x),Y, 2);
    plot(X(:,x),Y,'*',sort(X(:,x)),polyval(p,sort(X(:,x))));
    xlabel('Obesity rate'); ylabel('Happieness Index'); hold on
    title('Happieness Index v.s. Obesity rate')
    
a = 18; b = 12;
figure, 
    p = polyfit(X(:,a),X(:,b), 2);
    plot(X(:,a),X(:,b),'*',sort(X(:,a)),polyval(p,sort(X(:,a))));
    xlabel('Urban population'); ylabel('Life expectancy at birth'); hold on
    title('Urban population v.s. Life expectancy at birth')    
    
a = 38; b = 39;
figure, 
    p = polyfit(X(:,a),X(:,b), 2);
    plot(X(:,a),X(:,b),'*',sort(X(:,a)),polyval(p,sort(X(:,a))));
    xlabel('unemployment fem'); ylabel('unemployment male'); hold on
    title('unemployment fem v.s. unemployment male')        
    
a = 4; b = 1;
figure, 
    p = polyfit(X(:,a),X(:,b), 2);
    plot(X(:,a),X(:,b),'*',sort(X(:,a)),polyval(p,sort(X(:,a))));
    xlabel('Fertility rate'); ylabel('Age dependency ratio'); hold on
    title('Fertility rate v.s. Age dependency ratio')            
    

%% PCA

% standardization 
X = zscore(X);
[n,p] = size(X);
PCRmsep = sum(crossval(@pcrsse,X,Y,'kfold',10),1) / n;
figure, plot(0:length(PCRmsep)-1,PCRmsep,'-^');
    title('PCR'); xlabel('Number of components');   
    ylabel('Estimated Mean Squared Prediction Error');
% optimal # of pc
PCAnumpc = 20;
[PCALoadings,PCAScores,PCAVar] = pca(X,'Economy',false);
betaPCR = regress(Y-mean(Y), PCAScores(:,1:PCAnumpc));
% yfitPCR_test = PCAScores(:,1:numpc)*betaPCR+mean(Y)*ones(31,1);  %this one is almost the same as the following one
betaPCR = PCALoadings(:,1:PCAnumpc)*betaPCR;
betaPCR = [mean(Y) - mean(X)*betaPCR; betaPCR];
yfitPCR = [ones(n,1) X]*betaPCR;

figure, plot(Y,yfitPCR,'r^', [min(Y) max(Y)],[min(Y) max(Y)],':');
    xlabel('Observed Response'); ylabel('Fitted Response'); hold on
    
figure, plot(1:size(PCAVar), 100*cumsum(PCAVar(1:size(PCAVar)))/sum(PCAVar(1:size(PCAVar))),'-^');
    xlabel('Number of Principal Components'); grid on;
    ylabel('Percent Variance Explained in X');
    legend({'PCR'},'location','SE');    
    
figure, 
    p = polyfit(PCAScores(:,1),Y, 2);
    plot(PCAScores(:,1),Y,'*',sort(PCAScores(:,1)),polyval(p,sort(PCAScores(:,1))));
    xlabel('PCAscore1'); ylabel('Happieness Index'); 
    title('Happieness Index v.s.PCAscore1')
    
figure, 
    p = polyfit(PCAScores(:,2),Y, 2);
    plot(PCAScores(:,2),Y,'*',sort(PCAScores(:,2)),polyval(p,sort(PCAScores(:,2))));
    xlabel('PCAscore2'); ylabel('Happieness Index'); 
    title('Happieness Index v.s.PCAscore2')

figure, plot(PCALoadings(:,1), PCALoadings(:,2),'*')
    xlabel('PCALoadings1'); ylabel('PCALoadings2'); 
    title('PCALoadings1 v.s. PCALoadings2')
% kmeans
    tem = [PCALoadings(:,1) PCALoadings(:,2)];
    [idx,C] = kmeans(tem,3);
    figure,
        plot(tem(idx==1,1),tem(idx==1,2),'.','MarkerSize',12); hold on;
        plot(tem(idx==2,1),tem(idx==2,2),'.','MarkerSize',12);
        plot(tem(idx==3,1),tem(idx==3,2),'.','MarkerSize',12);
        plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
        legend('Cluster 1','Cluster 2','Cluster 3','Centroids', 'Location','NW')
        xlabel('PCALoadings1'); ylabel('PCALoadings2'); 
        title('PCALoadings1 v.s. PCALoadings2')

figure, plot(PCAScores(:,1), PCAScores(:,2),'*')
    xlabel('PCAscore1'); ylabel('PCAscore2'); 
    title('PCAscore1 v.s. PCAscore2')
% kmeans
    tem = [PCAScores(:,1) PCAScores(:,2)];
    [idx,C] = kmeans(tem,2);
    figure,
        plot(tem(idx==1,1),tem(idx==1,2),'.','MarkerSize',12); hold on;
        plot(tem(idx==2,1),tem(idx==2,2),'.','MarkerSize',12);
    %     plot(tem(idx==3,1),tem(idx==3,2),'.','MarkerSize',12);
        plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
        legend('Cluster 1','Cluster 2','Centroids', 'Location','NW')
        title('PCAscore1 v.s. PCAscore2')
        xlabel('PCAscore1'); ylabel('PCAscore2'); 
    
%%  PLS
[Xl,Yl,Xs,Ys,beta,pctVar,PLSmsep] = plsregress(X,Y,10,'CV',10);
figure, plot(0:10,PLSmsep(2,:),'-o')
xlabel('Number of components'); ylabel('Estimated Mean Squared Prediction Error');
    
% optimal # of pc 
PLSnumpc = 2;
[Xloadings,Yloadings,Xscores,Yscores,betaPLS] = plsregress(X,Y,PLSnumpc);
yfitPLS = [ones(n,1) X]*betaPLS;

figure, 
    p = polyfit(Xscores(:,1),Y, 2);
    plot(Xscores(:,1),Y,'*',sort(Xscores(:,1)),polyval(p,sort(Xscores(:,1))));
    xlabel('PLSscore1'); ylabel('Happieness Index'); hold on
    title('Happieness Index v.s.PLSscore1')
       
figure, 
    p = polyfit(Xscores(:,2), Y, 2);
    plot(Xscores(:,2),Y ,'*',sort(Xscores(:,2)),polyval(p,sort(Xscores(:,2))));
    xlabel('PLSscore2'); ylabel('Happieness Index'); hold on
    title('Happieness Index v.s.PLSscore2')

figure, plot(Xloadings(:,1), Xloadings(:,2),'*')
    xlabel('PLSloadings1'); ylabel('PLSloadings2'); 
    title('PLSloadings1 v.s. PLSloadings2')
figure, plot(Xscores(:,1), Xscores(:,2),'*')
    xlabel('PLSscore1'); ylabel('PLSscore2'); 
    title('PLSscore1 v.s. PLSscore2')
    
%% compare PLSR PCA
figure, xlabel('Number of components'); ylabel('Estimated Mean Squared Prediction Error'); hold on
plot(0:10,PLSmsep(2,:),'-o',0:10,PCRmsep(1:11),'-^');
legend({'PLSR' 'PCR'},'location','NE');