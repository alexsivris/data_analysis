function [] = scatter_plot_variable(index)
Preanalysis_Plot;

X = X(:,index);
% X = [X , ones(length(X))];
y= y(:,1);

mdl=fitlm(X,y,'linear');
plot(mdl)
title(['The relation between variables and Satisfaction score ']);
xlabel(strrep(X_variables(index),'_',' '));
ylabel(['Satisfaction Score']);

end
