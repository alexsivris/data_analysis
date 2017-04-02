Preanalysis_Plot;
% fill nan values with mean
colMean = nanmean(X);
[row,col] = find(isnan(X));
X(isnan(X)) = colMean(col);

[R,P]= corrcoef([X,y]);

pcolor(R)
colormap(gray(16))
axis ij
axis square
title('Colored Image of Correlation coefficients between columns of the data matrix')