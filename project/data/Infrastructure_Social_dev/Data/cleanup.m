clc, clear all, close all;
% This is a simple script to find out which countries in our data set are
% also represented in the world happiness report.

%read data
codes = readtable('country_codes/iso_3166_2_countries.csv');
tab = readtable('population_living_in_slums_percentage_of_urban_population/population_living_in_slums.csv');
whr = readtable('world_happiness_report_2016/whr_2016.csv');
% check avg_connection_speed
avg_connection_speed(:,1).Geography = upper(avg_connection_speed(:,1).Geography);
%table
Country = {};
Country_Rank = [];
Internet_Speed = [];
for m=1:size(avg_connection_speed,1)
    %get country code from table
    country_code = avg_connection_speed(m,1).Geography;
    
    
    %convert country name from code
    code_id = find(strcmp(country_code,codes(:,11).ISO3166_12LetterCode));
    for n=1:size(code_id,1)
        country_name = codes(code_id(n,1),2).CommonName;
        
        %check if this name is in Y (whr)
        in_y = find(strcmp(country_name,whr(:,2).Country));
        if (in_y)
            Country(end+1) = {country_name};
            Country_Rank(end+1) = in_y;
            Internet_Speed(end+1) = avg_connection_speed(m,2).kbps;
            
        end
    end
end

T = table(Country',Country_Rank',Internet_Speed');
T.Properties.VariableNames = {'Country' 'Country_Rank' 'Internet_Speed'};

% now get only countries
only_countries = T(:,1).Country;
