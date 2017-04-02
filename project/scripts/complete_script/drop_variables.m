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

%  standardization 
X = zscore(X); X_org = X;
[n,p] = size(X);

%%  PLSR
% reset the X 
X = X_org; X_merge = X_merge_org;
clear opnumpc pcc mse
X_drop_PLSR = table; % to store the variables which are dropped

for ir = 1:size(X_org,2)-10
    % decide the optimal # of pc by 10 fold cross-validation
    [Xloadings,Yloadings,Xscores,Yscores,betaPLS,pctVar,PLSmsep] = plsregress(X,Y,size(X,2),'CV',size(X,1));
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

figure, plot(0:ir-1,pcc,'.-',41,pcc(41+1),'o'), title('PCC v.s.# of dropped variables'); hold on
%     [v ind] = max(pcc); plot(ind-1,v,'o');
    xlabel('# of dropped variables'); ylabel('Pearson correlation coefficient'); 
    set(gca,'FontSize',FONTSIZE);
% figure, plot(0:ir-1,mse,'.-'), title('MSE v.s.# of dropped variables'); hold on
%     [v ind] = min(mse); plot(ind-1,v,'o');
%     xlabel('# of dropped variables'); ylabel('Estimated Mean Squared Prediction Error'); 



% optimal x is 41
%%  PCR
% reset the X 
X = X_org; X_merge = X_merge_org;
clear opnumpc pcc mse
X_drop_PCR = table; % to store the variables which are dropped

for ir = 1:size(X_org,2)-8
    % decide the optimal # of pc by 10 fold cross-validation  
    PCRmsep = sum(crossval(@pcrsse,X,Y,'leaveout',1),1) / n;
%     figure, plot(0:size(PCRmsep,2)-1,PCRmsep,'-o')
%     xlabel('Number of components'); ylabel('Estimated Mean Squared Prediction Error');  

    IN = find(diff(PCRmsep)>0);  % the first local minimum MSEP
%     if isempty(IN) 
%         PCAnumpc = 5 ;
%     else
        PCAnumpc = IN(1) -1 ;
%     end
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

figure, plot(0:ir-1,pcc,'.-', 54,pcc(54+1),'o' ), title('PCC v.s.# of dropped variables'); hold on
%     [v ind] = max(pcc); plot(ind-1,v,'o');

    xlabel('# of dropped variables'); ylabel('Pearson correlation coefficient'); 
    set(gca,'FontSize',FONTSIZE);
% figure, plot(0:ir-1,mse,'.-'), title('MSE v.s.# of dropped variables'); hold on
%     [v ind] = min(mse); plot(ind-1,v,'o');
%     xlabel('# of dropped variables'); ylabel('Estimated Mean Squared Prediction Error'); 

% optimal x is 54