clc, clear all, close all;
X_tab = load('X.mat');
Y_tab = load('Y.mat');

% convert table to array
X = X_tab.X{:,:};
Y = Y_tab.Y_new{:,:};

% centering and normalizing
% X = X - ones(size(X,1),1)*mean(X); % mean over rows

% locate remaining nans
locate_nan = zeros(size(X));
counter = 1;
for m=1:size(X,1)
    for n=1:size(X,2)
        if (isnan(X(m,n)))
            locate_nan(m,n) = 1;
            disp(sprintf('Located %d. NaN at: (%d, %d)',counter,m,n));
            % replace it with the mean
            all_nans = find(~isnan(X(:,n)));
            X_temp = X(all_nans);
            X(m,n) = mean(X_temp);
            counter = counter+1;
        end
    end
end

X_no_nans = X;
Y_before = Y;
% centering 
X = X - ones(size(X,1),1)*mean(X); % mean over rows
Y = Y - ones(size(Y,1),1)*mean(Y);

% normalizing
X = bsxfun (@rdivide, X, std(X_no_nans));
Y = bsxfun (@rdivide, Y, std(Y_before));

% PCA
[n,p] = size(X);
[PCALoadings,PCAScores,PCAVar] = pca(X,'Economy',false);


