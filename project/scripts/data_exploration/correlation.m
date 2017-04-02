Preanalysis_Plot;
% fill nan values with mean
colMean = nanmean(X);
[row,col] = find(isnan(X));
X(isnan(X)) = colMean(col);

[R,P]= corrcoef([X,y]);
corr_with_y = R(68,1:67);

indexes = abs(corr_with_y) > mean(abs(corr_with_y));
y_new = corr_with_y(indexes);
Variables = X_variables(indexes);
len = length(y_new);
bar(y_new)
ax = gca;
ax.XTick = (1:len);
for i=1:len
    
    a(i) = strrep(Variables(i),'_',' ');
end
ax.XTickLabel = a;
ax.XTickLabelRotation = 90;
xlabel('Variables');
ylabel('Correlation coeff with Life Satisfaction Score');
title('Importantce of Variables')
grid on