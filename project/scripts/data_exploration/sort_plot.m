Preanalysis_Plot;
[y_sort , I] = sort(y, 'ascend');
sorted_countries = X_rows(I);
plot(y_sort,'--*')
ax = gca;
ax.XTickLabel = sorted_countries(1:2:end);
ax.XTick = (1:2:length(y_sort));

ax.XTickLabelRotation = 90;
xlabel('Countries');
ylabel('Satisfaction Score');
title('Sorted Satisfaction Score according to Countries')
grid on
% variance_y =
% 
%     1.3538
% 
% 
% mean_y =
% 
%     5.4480
% 
% 
% median_y =
% 
%     5.4640