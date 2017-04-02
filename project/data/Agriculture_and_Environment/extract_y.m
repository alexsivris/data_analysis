clc, clear all, close all;
load('X.mat');
load('Y.mat');

Y_new = table(zeros(size(X,1),1));
Y_new.Properties.VariableNames = {'Satisfaction_Score'};
Y_new.Properties.RowNames = X.Properties.RowNames;

%copy satisfaction score of correct countries into new vector
for m=1:size(Y_new,1)
    found = find(strcmp(Y_new(m,:).Properties.RowNames,Y{:,1}));
    Y_new(m,1) = array2table(str2double(Y{found,2}));
end
