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
%% cluster
% cluster Y
k = 3;
[idx,C] = kmeans(Y,k) ;
figure,  
for i = 1:k
    edges = [round(C(i))-2 :0.1:round(C(i))+2]; 
    histogram(Y(find(idx==i)),edges);hold on;
end
xlabel('Happieness Index'); ylabel('# of countries');

%%  PLSR
% reset the X 
X = X_org; X_merge = X_merge_org;
clear opnumpc pcc mse
X_drop_PLSR = table; % to store the variables which are dropped

% give the optimap number of PC
opmPC = 41;

for ir = 1:opmPC+1
    % decide the optimal # of pc by 10 fold cross-validation
    [Xloadings,Yloadings,Xscores,Yscores,betaPLS,pctVar,PLSmsep] = plsregress(X,Y,size(X,2),'CV',size(X,1));
    [v ind] = min(PLSmsep(2,:)); % the one which has smallest MSEP
    PLSnumpc = ind + -1 ;
    opnumpc(ir) = PLSnumpc;
    % do the plsr again by the optimal # of pc
    [Xloadings,Yloadings,Xscores,Yscores,betaPLS,pctVar,PLSmsep] = plsregress(X,Y,PLSnumpc);
    yfitPLS = [ones(n,1) X]*betaPLS;  % predicted Y
    pcc(ir) = corr(yfitPLS, Y);       % PCC between Y and predicted Y
    mse(ir) = PLSmsep(2,3);           % MSE between Y and predicted Y
    BETA = betaPLS(2:end);    
    if ir == opmPC+1 break; end
    
    % drop the variables which has smallest absolute weight 

    [v dis] = min(abs(BETA));
    X_drop_PLSR = [X_drop_PLSR X_merge(:,dis)];
    X(:,dis) = []; X_merge(:,dis) = [];
end

X_PLSR = X;
X_merge_PLSR  = X_merge;
Weight_PLSR = X_merge.Properties.VariableNames';
Weight_PLSR(:,2) = num2cell(betaPLS(2:end));


%%  PCR
% reset the X 
X = X_org; X_merge = X_merge_org;
clear opnumpc pcc mse
X_drop_PCR = table; % to store the variables which are dropped

% give the optimap number of PC
opmPC = 54;

for ir = 1:opmPC+1
    % decide the optimal # of pc by 10 fold cross-validation  
    PCRmsep = sum(crossval(@pcrsse,X,Y,'leaveout',1),1) / n;

    IN = find(diff(PCRmsep)>0);  % the first local minimum MSEP
    
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
    
    if ir == opmPC+1 break; end
    
    % drop the variables which has smallest absolute weight 
    [v dis] = min(abs(BETA));
    X_drop_PCR = [X_drop_PCR X_merge(:,dis)];
    X(:,dis) = []; X_merge(:,dis) = [];

end


X_PCR = X;
X_merge_PCR  = X_merge;
Weight_PCR = X_merge.Properties.VariableNames';
Weight_PCR(:,2) = num2cell(BETA);

%% predict Y
figure, plot(Y,yfitPLS,'bo',Y,yfitPCR,'r^', [min(Y) max(Y)],[min(Y) max(Y)],'k:');
    xlabel('Observed Response'); ylabel('Fitted Response');
    legend({'PLSR with 7 Components' 'PCR with 8 Components'}, 'location','NW');
    set(gca,'FontSize',FONTSIZE);

%% weight
% PCR
figure, stem([Weight_PCR{:,2}]); hold on
    % for text label
    for ii = 1:length(Weight_PCR)
        if Weight_PCR{ii,2}>0
            text(ii-1, Weight_PCR{ii,2}+.007,strrep(Weight_PCR{ii,1},'_','\_'),'FontSize',13);
        else
            text(ii-1, Weight_PCR{ii,2}-.007,strrep(Weight_PCR{ii,1},'_','\_'),'FontSize',13);
        end
    end
    xlabel('features'); ylabel('weight'); 
    title('PCA weight')
    set(gca,'FontSize',FONTSIZE);
    axis([0 length(Weight_PCR)+4 -0.15 0.15]); 


% PLSR
figure, stem(betaPLS(2:end))
    % for text label
    for ii = 1:length(Weight_PLSR)
        if Weight_PLSR{ii,2}>0
            text(ii-1, Weight_PLSR{ii,2}+.007,strrep(Weight_PLSR{ii,1},'_','\_'),'FontSize',10);
        else
            text(ii-1, Weight_PLSR{ii,2}-.007,strrep(Weight_PLSR{ii,1},'_','\_'),'FontSize',10);
        end
    end
    xlabel('features'); ylabel('weight'); 
    title('PLSR weight')
    set(gca,'FontSize',FONTSIZE);

%% loading plot
% PCR
figure, plot(PCALoadings(:,1), PCALoadings(:,2),'o'); grid on;
    xlabel('1^s^t loading'); ylabel('2^n^d loading'); 
    title('PCA 1^s^t loading v.s. 2^n^d loading')
    % Add textCell
    for ii = 1:length(PCALoadings(:,1))
        text(PCALoadings(ii,1)+.02, PCALoadings(ii,2)+.02,strrep(X_merge_PCR.Properties.VariableNames{ii},'_','\_'),'FontSize',10) 
    end
    set(gca,'FontSize',FONTSIZE);
    axis([-0.4 1 -0.4 0.8]); 
    
    % kmeans
    k = 4; % number of clusters
    tem = [PCALoadings(:,1) PCALoadings(:,2)];
    [idx,C] = kmeans(tem,k,'Replicates',35,'Display','final');
    figure,
        for i = 1:k
            plot(tem(idx==i,1),tem(idx==i,2),'.','MarkerSize',15); hold on
        end
%         plot(C(:,1),C(:,2),'kx','MarkerSize',10,'LineWidth',3); grid on;
    %         legend('Cluster 1','Cluster 2','Cluster 3','Centroids', 'Location','NW')
    xlabel('1^s^t loading'); ylabel('2^n^d loading'); 
    title('PCA 1^s^t loading v.s. 2^n^d loading')
    for ii = 1:length(PCALoadings(:,1))
        text(PCALoadings(ii,1)+.02, PCALoadings(ii,2)+.02,strrep(X_merge_PCR.Properties.VariableNames{ii},'_','\_'),'FontSize',10) 
    end
    set(gca,'FontSize',FONTSIZE);
    axis([-0.4 1 -0.4 0.8]); 
    
% PLSR
figure, plot(Xloadings(:,1), Xloadings(:,2),'o'); grid on;
    xlabel('1^s^t loading'); ylabel('2^n^d loading'); 
    title('PLS 1^s^t loading v.s. 2^n^d loading')
    % Add textCell
    for ii = 1:length(Xloadings(:,1))
        text(Xloadings(ii,1)+.02, Xloadings(ii,2)+.02,strrep(X_merge_PLSR.Properties.VariableNames{ii},'_','\_'),'FontSize',10) 
    end
    set(gca,'FontSize',FONTSIZE);
    axis([-15 25 -11 7]); 
    
    % kmeans
    k = 5; % number of clusters
    tem = [Xloadings(:,1) Xloadings(:,2)];
    [idx,C] = kmeans(tem,k,'Replicates',35,'Display','final');
    figure,
        for i = 1:k
            plot(tem(idx==i,1),tem(idx==i,2),'.','MarkerSize',15); hold on
        end
%         plot(C(:,1),C(:,2),'kx','MarkerSize',10,'LineWidth',3); grid on;
    xlabel('1^s^t loading'); ylabel('2^n^d loading'); 
    title('PLS 1^s^t loading v.s. 2^n^d loading')
    for ii = 1:length(Xloadings(:,1))
        text(Xloadings(ii,1)+.02, Xloadings(ii,2)+.02,strrep(X_merge_PLSR.Properties.VariableNames{ii},'_','\_'),'FontSize',10) 
    end
    set(gca,'FontSize',FONTSIZE);
    axis([-15 25 -11 7]); 

%% cluster Y
k = 3;
[idx_Y,C_Y] = kmeans(Y,k,'Replicates',30) ;
[B,I] = sort(C_Y);
figure,  
    for i = [I']
        edges = [round(C_Y(i))-2 :0.1:round(C_Y(i))+2]; 
        histogram(Y(find(idx_Y==i)),edges);hold on;
    end
    xlabel('Happieness Index'); ylabel('# of countries');
    legend('low','medium','high', 'location','NW');
    
%% score plot
% PCR
figure, plot(PCAScores(:,1), PCAScores(:,2),'o'); grid on;
    xlabel('1^s^t score'); ylabel('2^n^d score'); 
    title('PCA 1^s^t score v.s. 2^n^d score')
    % Add text
%     for ii = 1:length(PCAScores(:,1))
%         text(PCAScores(ii,1)+.05, PCAScores(ii,2)+.05,X_merge_PCR.Properties.RowNames{ii},'FontSize',10) 
%     end
    set(gca,'FontSize',FONTSIZE);

figure,
    for i = [I']
        plot(PCAScores(idx_Y==i,1),PCAScores(idx_Y==i,2),'.','MarkerSize',15); hold on
    end
    legend('low','medium','high', 'location','best')
    set(gca,'FontSize',FONTSIZE);
    
    % kmeans
    k = 3; % number of clusters
    tem = [PCAScores(:,1) PCAScores(:,2)];
    [idx,C] = kmeans(tem,k,'Replicates',35,'Display','final');
    figure,
        for i = 1:k
            plot(tem(idx==i,1),tem(idx==i,2),'.','MarkerSize',15); hold on
        end
        plot(C(:,1),C(:,2),'kx','MarkerSize',10,'LineWidth',3); grid on;
    %         legend('Cluster 1','Cluster 2','Cluster 3','Centroids', 'Location','NW')
    xlabel('1^s^t score'); ylabel('2^n^d score'); 
    title('PCA 1^s^t score v.s. 2^n^d score')
    set(gca,'FontSize',FONTSIZE);
%     for ii = 1:length(PCAScores(:,1))
%         text(PCAScores(ii,1)+.02, PCAScores(ii,2)+.02,X_merge_PCR.Properties.RowNames{ii},'FontSize',10) 
%     end
    
    
% PLSR
figure, plot(Xscores(:,1), Xscores(:,2),'o'); grid on;
    xlabel('1^s^t score'); ylabel('2^n^d score'); 
    title('PLS 1^s^t score v.s. 2^n^d score')
    % Add text
%     for ii = 1:length(Xscores(:,1))
%         text(Xscores(ii,1)+.02, Xscores(ii,2)+.02,X_merge_PLSR.Properties.RowNames{ii},'FontSize',10) 
%     end
%     set(gca,'FontSize',FONTSIZE);
    
    figure,
    for i = [I']
        plot(Xscores(idx_Y==i,1),Xscores(idx_Y==i,2),'.','MarkerSize',15); hold on
    end
    legend('low','medium','high', 'location','best'); grid on;
    xlabel('1^s^t score'); ylabel('2^n^d score'); 
    title('PLS 1^s^t score v.s. 2^n^d score')
    set(gca,'FontSize',FONTSIZE);
    
    % kmeans
    k = 3; % number of clusters
    tem = [Xscores(:,1) Xscores(:,2)];
    [idx,C] = kmeans(tem,k,'Replicates',35,'Display','final');
    figure,
        for i = 1:k
            plot(tem(idx==i,1),tem(idx==i,2),'.','MarkerSize',15); hold on
        end
        plot(C(:,1),C(:,2),'kx','MarkerSize',10,'LineWidth',3); grid on;
    %         legend('Cluster 1','Cluster 2','Cluster 3','Centroids', 'Location','NW')
    xlabel('1^s^t score'); ylabel('2^n^d score'); 
    title('PLS 1^s^t score v.s. 2^n^d score')
    set(gca,'FontSize',FONTSIZE);
%     for ii = 1:length(Xscores(:,1))
%         text(Xscores(ii,1)+.02, Xscores(ii,2)+.02,X_merge_PLSR.Properties.RowNames{ii},'FontSize',10) 
%     end
    