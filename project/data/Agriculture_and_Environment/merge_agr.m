clc, clear all, close all;
load('all_vars_agr.mat');


all_vars = who('*');

vars_137 = [{}];
vars_138 = [{}];

%sort out variables with 137 and 138 countries
for m=1:size(all_vars,1)
    tmp_tab = eval(all_vars{m,1});
    if (size(tmp_tab,1)==137)
        vars_137(end+1,1) = all_vars(m,1);
    end
    
    if (size(tmp_tab,1)==138)
        vars_138(end+1,1) = all_vars(m,1);
    end
end

% check if the countries match within vars_137
countries_match_137 = [];
for m=1:size(vars_137)
    tmp_tab = eval(vars_137{m,1});
    for n=1:size(vars_137)
        tmp_tab2 = eval(vars_137{n,1});
        match = strcmp(tmp_tab{:,3},tmp_tab2{:,3});
        if (match ~= ones(size(match)))
            countries_match_137(m,n) = 0;
        else
            countries_match_137(m,n) = 1;
        end
    end
end
% fine !

% same vor vars_138
countries_match_138 = [];
for m=1:size(vars_138)
    tmp_tab = eval(vars_138{m,1});
    for n=1:size(vars_138)
        tmp_tab2 = eval(vars_138{n,1});
        match = strcmp(tmp_tab{:,1},tmp_tab2{:,1});
        if (match ~= ones(size(match)))
            countries_match_138(m,n) = 0;
        else
            countries_match_138(m,n) = 1;
        end
    end
end
% also fine !

% create x matrix for 137 countries
data = zeros(size(vars_137,1),137);
T = array2table(data');
h = vars_137(:,1);
T.Properties.VariableNames = h;

% rename rows
tmp = eval(vars_137{1,1});
h = tmp{:,3};
T.Properties.RowNames = h;

% 
for n=1:size(vars_137,1)
    for m=1:size(tmp,1)
        tab = eval(vars_137{n,1});
        match_nan = 1;
        counter = size(tab,2);
        while (match_nan && counter > 5)
            if (~iscell(tab{m,counter}))
                if (isnan(tab{m,counter}))
                    counter = counter - 1;
                    if (counter == 5), T(m,n) = table(nan); end
                else
                    T(m,n) = array2table([tab{m,counter}]);
                    match_nan = 0;
                    break;
                end
            end
            
            if (iscell(tab{m,counter}))
                % remove american comma...
                num = str2double(strrep(tab{m,counter},',',''));
                if (isnan(num))
                    counter = counter - 1;
                    if (counter == 5), T(m,n) = table(nan); end
                else
                    T(m,n) = array2table([num]);
                    match_nan = 0;
                end
                
            end
        end
    end
end

% create x matrix for 138 countries
data = zeros(size(vars_138,1),138);
T2 = array2table(data');
h = vars_138(:,1);
T2.Properties.VariableNames = h;

% rename rows
tmp = eval(vars_138{1,1});
h = tmp{:,1};
T2.Properties.RowNames = h;

% 
for n=1:size(vars_138,1)
    for m=1:size(tmp,1)
        tab = eval(vars_138{n,1});
        match_nan = 1;
        counter = size(tab,2);
        while (match_nan && counter > 4)
            if (~iscell(tab{m,counter}))
                if (isnan(tab{m,counter}))
                    counter = counter - 1;
                    if (counter == 4), T2(m,n) = table(nan); end
                else
                    T2(m,n) = array2table([tab{m,counter}]);
                    match_nan = 0;
                    break;
                end
            end
            
            if (iscell(tab{m,counter}))
                % remove american comma...
                num = str2double(strrep(tab{m,counter},',',''));
                if (isnan(num))
                    counter = counter - 1;
                    if (counter == 4), T2(m,n) = table(nan); end
                else
                    T2(m,n) = array2table([num]);
                    match_nan = 0;
                end
                
            end
        end
    end
end

%% south sudan isn't inside vars_137
h = vars_137(:,1);
tmp_sudan = array2table(NaN(1,size(T,2)));
tmp_sudan.Properties.VariableNames = h;
tmp_sudan.Properties.RowNames = population_total{114,1};
T = [T;tmp_sudan];
T(115:end,:) = T(114:137,:);
T.Properties.RowNames = population_total{:,1};
T(114,:) = tmp_sudan;

% T2(115:138) = T();
X = array2table(zeros(138,size(T,2)+size(T2,2)));
h = [T.Properties.VariableNames T2.Properties.VariableNames];
X.Properties.VariableNames = h;
X.Properties.RowNames = T.Properties.RowNames;

X(:,1:size(T,2)) = T;
X(:,size(T,2)+1:end) = T2;