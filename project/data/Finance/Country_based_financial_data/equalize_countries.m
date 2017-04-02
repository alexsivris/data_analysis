clc, close all, clear all;

load('X_Ahmet.mat')
load('X.mat');

data = cell(1,size(XAhmet,2));
XAhmet_new = XAhmet(:,3:end);
XAhmet_new.Properties.RowNames = XAhmet{:,1};
XAhmet_new.Properties.VariableNames = XAhmet(:,3:end).Properties.VariableNames;


a1 = X.Properties.RowNames;
a2 = XAhmet{:,1};
Found = XAhmet_new(1,:);
notFound = XAhmet_new(1,:);
tab = {};
for m=1:size(a1,1)
    idx = find(strcmp(X(m,:).Properties.RowNames,XAhmet_new(:,:).Properties.RowNames));
    if (idx)
        Found(end+1,:) = XAhmet_new(idx,:);
        tab(end+1,:) = XAhmet_new(idx,:).Properties.RowNames;
%         Found(end+1,:).Properties.RowNames = XAhmet_new(m,:).Properties.RowNames;
    else
        notFound(end+1,:) = XAhmet_new(idx,:);
%         notFound(end+1,:).Properties.RowNames = XAhmet_new(m,:).Properties.RowNames;
    end
end
Found(1,:) = [];
Found.Properties.RowNames = tab(:,1);

X_Ahmet = Found;
