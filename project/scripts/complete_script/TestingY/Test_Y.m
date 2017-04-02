clc, clear all, close all;
%% load data
load Y
load X_Agriculture
load X_Finance
load X_Health
load X_SocialDev
load Weight_PCR
load Weight_PLSR

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
%countries for test
TEST = X(discard_country,:); 
TEST_table = X_merge(discard_country,:);
Y_test = Y(discard_country);

X(discard_country,:) = [];
X_merge(discard_country,:) = []; 
Y(discard_country) = [];
X_merge_org = X_merge;

% replace nan with mean
Mean = mean(X,'omitnan');
% Determine addresses of missing values
Index = find(isnan(X)); 
[i,k] = find(isnan(X)); 
% Replace missing values by column means
X(Index) = Mean(k); 

%  standardization 
[X,mu,sigma]  = zscore(X); X_org = X;

%% preprocessing
% Replace missing values by column means of training data
Index = find(isnan(TEST)); 
[i,k] = find(isnan(TEST)); 
TEST(Index) = Mean(k); 

% centering and normalizing the testing data
TEST = TEST- ones(2,1)*mu;
TEST = TEST ./ (ones(2,1)*sigma);
%% PLSR
% find the matching variables
for m=2:size(Weight_PLSR,1)
        idx = find(strcmp(Weight_PLSR(m,1), TEST_table.Properties.VariableNames));
        TEST_PLSR(:,m-1) = TEST(:,idx);
        TEST_PLSR_table(:,m-1) = TEST_table(:,idx);
        TEST_PLSR_table.Properties.VariableNames(:,m-1) = TEST_table.Properties.VariableNames(:,idx);
end
TEST_PLSR_table.Properties.RowNames = TEST_table.Properties.RowNames;

% multiply with weight of each variable 
[n,p] = size(TEST_PLSR);
yfitPLS = [ones(n,1) TEST_PLSR]*[Weight_PLSR{:,2}]';
%% PCR
% find the matching variables
for m=1:size(Weight_PCR,1)
        idx = find(strcmp(Weight_PCR(m,1), TEST_table.Properties.VariableNames));
        TEST_PCR(:,m) = TEST(:,idx);
        TEST_PCR_table(:,m) = TEST_table(:,idx);
        TEST_PCR_table.Properties.VariableNames(:,m) = TEST_table.Properties.VariableNames(:,idx);
end
TEST_PCR_table.Properties.RowNames = TEST_table.Properties.RowNames;

betaPCR = [mean(Y); [Weight_PCR{:,2}]'];
yfitPCR = [ones(n,1) TEST_PCR]*betaPCR;
%% plot the predicting result
Y_predict = table;
Y_predict(:,1) = num2cell(Y_test);
Y_predict(:,2) = num2cell(yfitPLS);
Y_predict(:,3) = num2cell(yfitPCR);
Y_predict.Properties.RowNames([1 2],:) = TEST_table.Properties.RowNames;
Y_predict.Properties.VariableNames = {'Y' 'Y_PLSR' 'Y_PCR'};

Y_predict_arr = table2array(Y_predict);
figure, 
    plot(Y_predict_arr(:,1),Y_predict_arr(:,2),'^',...
         Y_predict_arr(:,1),Y_predict_arr(:,3),'o','MarkerSize',10,'LineWidth',2); hold on;
    plot(Y_predict_arr(:,1),Y_predict_arr(:,1),'kx','MarkerSize',10,'LineWidth',3);
    plot([3.6 5.8],[3.6 5.8],'k:');
    xlabel('Observed Response'); ylabel('Fitted Response');
    legend({'PLSR' 'PCR'}, 'location','NW'); title('predicted Y');
    text(Y_predict_arr(1,1)-0.2,Y_predict_arr(1,1)-0.2,'South Sudan','FontSize',FONTSIZE);
    text(Y_predict_arr(2,1)-0.15,Y_predict_arr(2,3)+0.2,'Kosovo','FontSize',FONTSIZE);
    set(gca,'FontSize',FONTSIZE);

% based on these 2 countries, I caculated the MSE.
MSE(:,1) = mse(Y_predict_arr(:,2),Y_predict_arr(:,1));
MSE(:,2) = mse(Y_predict_arr(:,3),Y_predict_arr(:,1));
figure,
    bar([ 0 MSE 0]);
    set(gca,'xtickLabel',{' ' 'PLSR' 'PCR' ' '});
    xlabel('Method'); ylabel('Estimated Mean Squared Prediction Error');
    text([2 3],MSE,{num2str(MSE(1),'%0.3f') num2str(MSE(2),'%0.3f')},...
        'HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',FONTSIZE) ;
    title('MSE of testing');
    set(gca,'FontSize',FONTSIZE);
% As we expected, the predicting result of PLSR is better than PCR.