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
X_merge(discard_country,:) = []; X_merge_org = X_merge;
Y(discard_country) = [];
% replace nan with mean
Mean = mean(X,'omitnan');
% Determine addresses of missing values
Index = find(isnan(X));
[i,k] = find(isnan(X));
% Replace missing values by column means
X(Index) = Mean(k);

%%  standardization 
X = zscore(X); X_org = X;
[n,p] = size(X);

%%  PLSR
% reset the X 
X = X_org; X_merge = X_merge_org;
clear opnumpc pcc mse
X_drop_PLSR = table; % to store the variables which are dropped

for ir = 1:size(X,2)-10
    % decide the optimal # of pc by leave-one-out cross-validation
    [Xloadings,Yloadings,Xscores,Yscores,betaPLS,pctVar,PLSmsep] = plsregress(X,Y,size(X,2),'CV',size(X,2));
%     figure, plot(0:size(PLSmsep,2)-1,PLSmsep(2,:),'-o')
%     xlabel('Number of components'); ylabel('Estimated Mean Squared Prediction Error');    
    [v ind] = min(PLSmsep(2,:)); % the one which has smallest MSEP
    PLSnumpc = ind + -1 ;
    opnumpc(ir) = PLSnumpc;
    % do the plsr again by the optimal # of pc
    [Xloadings,Yloadings,Xscores,Yscores,betaPLS,pctVar,PLSmsep] = plsregress(X,Y,PLSnumpc);
    yfitPLS = [ones(n,1) X]*betaPLS;  % predicted Y
    pcc(ir) = corr(yfitPLS, Y);       % PCC between Y and predicted Y
    mse(ir) = PLSmsep(2,3);           % MSE between Y and predicted Y
    
    % drop the variables which has smallest absolute weight 
    BETA = betaPLS(2:end);
    [v dis] = min(abs(BETA));
    X_drop_PLSR = [X_drop_PLSR X_merge(:,dis)];
    X(:,dis) = []; X_merge(:,dis) = [];
%     figure, stem(BETA)

%     figure, plot(Y,yfitPLS,'r^', [min(Y) max(Y)],[min(Y) max(Y)],':');
%     xlabel('Observed Response'); ylabel('Fitted Response'); hold on
end

figure, plot(0:ir-1,pcc,'.-'), title('PCC v.s.# of dropped variables'); hold on
    [v ind] = max(pcc); plot(ind-1,v,'o');
    xlabel('# of dropped variables'); ylabel('Pearson correlation coefficient'); 

figure, plot(0:ir-1,mse,'.-'), title('MSE v.s.# of dropped variables'); hold on
    [v ind] = min(mse); plot(ind-1,v,'o');
    xlabel('# of dropped variables'); ylabel('Estimated Mean Squared Prediction Error'); 

%%  PCR
% reset the X 
X = X_org; X_merge = X_merge_org;
clear opnumpc pcc mse
X_drop_PCR = table; % to store the variables which are dropped

for ir = 1:size(X,2)-10
    % decide the optimal # of pc by leave-one-out cross-validation  
    PCRmsep = sum(crossval(@pcrsse,X,Y,'leaveout',1),1) / n;
%     figure, plot(0:size(PCRmsep,2)-1,PCRmsep,'-o')
%     xlabel('Number of components'); ylabel('Estimated Mean Squared Prediction Error');  

    IN = find(diff(PCRmsep)>0);  % the first local minimum MSEP
    PCAnumpc = IN(1) -1 ;
    opnumpc(ir) = PCAnumpc;
    % do the pca again by the optimal # of pc
    [PCALoadings,PCAScores,PCAVar] = pca(X,'Economy',false);
    % predict Y
    betaPCR = regress(Y-mean(Y), PCAScores(:,1:PCAnumpc));
    betaPCR = PCALoadings(:,1:PCAnumpc)*betaPCR;
    BETA = betaPCR;
    betaPCR = [mean(Y) - mean(X)*betaPCR; betaPCR];
    
    yfitPCR = [ones(n,1) X]*betaPCR;            % predicted Y
    pcc(ir) = corr(yfitPCR, Y);                 % PCC between Y and predicted Y
    mse(ir) = sum(((Y-yfitPCR).^2)/length(Y));  % MSE between Y and predicted Y
    
    % drop the variables which has smallest absolute weight 
    [v dis] = min(abs(BETA));
    X_drop_PCR = [X_drop_PCR X_merge(:,dis)];
    X(:,dis) = []; X_merge(:,dis) = [];

%     figure, plot(Y,yfitPLS,'r^', [min(Y) max(Y)],[min(Y) max(Y)],':');
%     xlabel('Observed Response'); ylabel('Fitted Response'); hold on
end

figure, plot(0:ir-1,pcc,'.-'), title('PCC v.s.# of dropped variables'); hold on
    [v ind] = max(pcc); plot(ind-1,v,'o');
    xlabel('# of dropped variables'); ylabel('Pearson correlation coefficient'); 

figure, plot(0:ir-1,mse,'.-'), title('MSE v.s.# of dropped variables'); hold on
    [v ind] = min(mse); plot(ind-1,v,'o');
    xlabel('# of dropped variables'); ylabel('Estimated Mean Squared Prediction Error'); 

%% Clustering phase (only PLSR)
% reset the X 
X = X_org; X_merge = X_merge_org;
clear opnumpc pcc mse

% decide the optimal # of pc by 10-fold cross-validation
[Xloadings,Yloadings,Xscores,Yscores,betaPLS,pctVar,PLSmsep] = plsregress(X,Y,size(X,2),'CV',10);
% figure, plot(0:size(PLSmsep,2)-1,PLSmsep(2,:),'-o')
%     xlabel('Number of components'); ylabel('Estimated Mean Squared Prediction Error');    
[v ind] = min(PLSmsep(2,:)); % the one which has smallest MSEP
PLSnumpc = ind + -1 ;

% do the plsr again by the optimal # of pc
[Xloadings,Yloadings,Xscores,Yscores,betaPLS,pctVar,PLSmsep] = plsregress(X,Y,PLSnumpc);
    
figure, plot(Xloadings(:,1), Xloadings(:,2),'o'); grid on;
    xlabel('PLSloadings1'); ylabel('PLSloadings2'); 
    title('PLSloadings1 v.s. PLSloadings2')
    % Add textCell
    for ii = 1:length(Xloadings(:,1))
        text(Xloadings(ii,1)+.02, Xloadings(ii,2)+.02,X_merge.Properties.VariableNames{ii},'FontSize',10) 
    end
    
% kmeans
    k = 10; % number of clusters
    tem = [Xloadings(:,1) Xloadings(:,2)];
    [idx,C] = kmeans(tem,k);
    figure,
        for i = 1:k
            plot(tem(idx==i,1),tem(idx==i,2),'.','MarkerSize',15); hold on
        end
        plot(C(:,1),C(:,2),'kx','MarkerSize',10,'LineWidth',3); grid on;
%         legend('Cluster 1','Cluster 2','Cluster 3','Centroids', 'Location','NW')
        xlabel('PCALoadings1'); ylabel('PCALoadings2'); 
        title('PCALoadings1 v.s. PCALoadings2')
