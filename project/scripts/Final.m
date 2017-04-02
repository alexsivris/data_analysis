clc, clear all, close all;
%% load & clear data

load Y
load X
load X_Chun-Li
X_uncleared = table2array(X);
X_uncleared2 = table2array(X_ChunLi);
X = X_uncleared;

X2 = X_uncleared2;
X = [X X2];
Y = table2array(Y_new);
% replace nan with mean
for c = 1:size(X,2)
    col = X(:,c);
    ind = find(isnan(col));
    col(find(isnan(col)))=[];
    X(ind,c) = mean(col);
end

%normalize Alex Data
X_no_nans = X(:,1:26);
X(:,1:26) = X(:,1:26) - ones(size(X(:,1:26),1),1)*mean(X(:,1:26));
X(:,1:26) = bsxfun (@rdivide, X(:,1:26), std(X_no_nans));

%% PCA
[n,p] = size(X);
PCRmsep = sum(crossval(@pcrsse,X,Y,'leaveout',1),1) / n;
[min_val,min_ind] = min(PCRmsep);
vec = 0:length(PCRmsep)-1;
min_x = vec(min_ind);
figure, plot(0:length(PCRmsep)-1,PCRmsep,'-^');
hold on;
plot(min_x,min_val,'ro','markersize',10);
    title('PCR'); xlabel('Number of components');   
    ylabel('Estimated Mean Squared Prediction Error');
    
    grid on;
% optimal number of pc is 6
numpc = 6;
[PCALoadings,PCAScores,PCAVar] = pca(X,'Economy',false);
betaPCR = regress(Y-mean(Y), PCAScores(:,1:numpc));
% yfitPCR_test = PCAScores(:,1:numpc)*betaPCR+mean(Y)*ones(31,1);  %this one is almost the same as the following one
betaPCR = PCALoadings(:,1:numpc)*betaPCR;
betaPCR = [mean(Y) - mean(X)*betaPCR; betaPCR];
yfitPCR = [ones(n,1) X]*betaPCR;

figure, plot(Y,yfitPCR,'r^', [min(Y) max(Y)],[min(Y) max(Y)],':');
    xlabel('Observed Response'); ylabel('Fitted Response'); hold on;
    grid on;
%     legend({'PLSR with 7 Components' 'PCR with 8 Components'}, 'location','NW');
    
figure, plot(1:10, 100*cumsum(PCAVar(1:10))/sum(PCAVar(1:10)),'-^');
xlabel('Number of Principal Components');
ylabel('Percent Variance Explained in X');
legend({'PCR'},'location','SE');    
grid on;
% figure, 
%     p = polyfit(PCAScores(:,1),Y, 2);
%     plot(PCAScores(:,1),Y,'*',sort(PCAScores(:,1)),polyval(p,sort(PCAScores(:,1))));
%     xlabel('PCAscore1'); ylabel('Happieness Index'); title('Happieness Index v.s.PCAscore1')
% figure, 
%     p = polyfit(PCAScores(:,2),Y, 2);
%     plot(PCAScores(:,2),Y,'*',sort(PCAScores(:,2)),polyval(p,sort(PCAScores(:,2))));
%     xlabel('PCAscore2'); ylabel('Happieness Index'); title('Happieness Index v.s.PCAscore2')
% 
% figure, plot(PCALoadings(:,1), PCALoadings(:,2),'*')
% figure, plot(PCAScores(:,1), PCAScores(:,2),'*')

