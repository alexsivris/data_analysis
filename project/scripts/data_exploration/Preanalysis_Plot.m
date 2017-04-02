
% Load X
X_struct = load('X_final_for_ahmet.mat');
ss = fieldnames(X_struct);
X_temp = X_struct.(ss{1});
X = table2array(X_temp);
X_variables = X_temp.Properties.VariableNames;
X_rows = X_temp.Properties.RowNames;
% Load Y
Y_struct = load('Y.mat');
ss2 = fieldnames(Y_struct);
Y_temp = Y_struct.(ss2{2});
y= table2array(Y_temp);
y_variables = Y_temp.Properties.VariableNames;
y_rows = Y_temp.Properties.RowNames;

% y_rows 66 (Kosovo) and 114 (South Sudan) is deleted
y_rows = y_rows( [1:65,67:113,115:end] , : );
y  = y ( [1:65,67:113,115:end] , : );


