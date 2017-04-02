clc, clear all, close all;
load('dirty_X.mat');

%check for nans
for m=1:size(T,2)
    nanvec = isnan(T{:,3});
    nans = find(nanvec);
    if (find(nans))
    end
end


