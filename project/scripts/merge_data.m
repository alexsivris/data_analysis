clc, clear all, close all;
load('all_vars_ws.mat');

all_tab = who('*');
t_tab = [{}];
for m=1:size(all_tab,1)
    tmp_tab = eval(all_tab{m,1});
    if size(tmp_tab,1) ~= 138
        continue;
    else
        t_tab(end+1,1) = all_tab(m,1);
    end
    
end
all_tab = t_tab;
header = {'Country'};
data = cell(size(all_tab,1),1);
T = cell2table(data);
T.Properties.VariableNames = header;

counries_match = [];
% countries_match should be all ones if the countries match
for m=1:size(all_tab,1)
    tmp_tab = eval(all_tab{m,1});
    if (size(tmp_tab,1) ~= 138 || size(tmp_tab,2) ~= 60)
        continue;
    end
    for n=1:size(all_tab,1)
        tmp_tab2 = eval(all_tab{n,1});
        if (size(tmp_tab2,1) ~= 138 || size(tmp_tab2,2) ~= 60)
            continue;
        else
            
            match = strcmp(tmp_tab(:,1).Var1,tmp_tab2(:,1).Var1);
            if (match ~= ones(size(match)))
                counries_match(m,n) = 0;
            else
                counries_match(m,n) = 1;
            end
        end
    end
end

% create x matrix for 138 countries
data = zeros(size(all_tab,1),138);
T = array2table(data');
h = all_tab(:,1);
T.Properties.VariableNames = h;

%rename rows
h = access_to_electricity(:,1).Var1;
T.Properties.RowNames = h;

%fill table with all the data
%access to electricity - 2015
for m=1:size(access_to_electricity(:,57),1)
    T(m,1) = array2table([access_to_electricity{m,57}]);
end

%fixed broadband subs
for m=1:size(fixed_broadband_subs(:,59),1)
    T(m,2) = array2table([fixed_broadband_subs{m,59}]);
end

%gender parity
for m=1:size(gender_parity(:,59),1)
    T(m,3) = array2table([gender_parity{m,59}]);
end


% cleans up most of the X by searching for older data
for n=3:size(all_tab,1)
    for m=1:size(gov_expenditure_on_edu(:,59),1)
        tab = eval(all_tab{n,1});
        match_nan = 1;
        counter = 59;
        while (match_nan && counter >= 5)
            if (~iscell(tab{m,counter}))
                if (isnan(tab{m,counter}))
                    counter = counter -1;
                else
                    T(m,n) = array2table([tab{m,counter}]);
                    match_nan = 0;
                    break;
                end
            end
        end
    end
end

% locate remaining nans
locate_nan = zeros(size(T));
counter = 1;
for m=1:size(T,1)
    for n=1:size(T,2)
        if (isnan(T{m,n}))
            locate_nan(m,n) = 1;
            disp(sprintf('Located %d. NaN at: (%d, %d)',counter,m,n));
            counter = counter+1;
        end
    end
end
