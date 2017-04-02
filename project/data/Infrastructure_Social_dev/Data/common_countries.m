 clc, clear all, close all;
% This is a simple script to find out which countries in our data set are
% also represented in the world happiness report.
%read data
file_path = 'land_area_total'; %folder
source_name = 'land_area_total.csv'; %filename
codes = readtable('country_codes/iso_3166_2_countries.csv'); 
tab = readtable(sprintf('%s/%s',file_path,source_name));
whr = readtable('world_happiness_report_2016/whr_2016.csv'); %the y
larger_idx = 0;
if (size(tab,1) > size(whr,1))
    larger_idx = size(tab,1);
else
    larger_idx = size(whr,1);
end
Found = tab(1,:);
notFound = tab(1,:);
% 1.) check which countries are in y
for m=1:larger_idx
    found = find(strcmp(tab{m,1},whr{:,2}));
    if (found)
        Found(end+1,:) = tab(m,:);
    else
        notFound(end+1,:) = tab(m,:);
    end
end
Found(1,:) = [];
notFound(1,:) = [];
Found = sortrows(Found);
notFound = sortrows(notFound);

% 2.) save to mat file
save(sprintf('%s/countries_in_y.mat',file_path),'Found','notFound');
