clc, clear all, close all;
load('all_vars_fin.mat');

all_tab = who('*');
t_tab = [{}];
t_tab_137 = [{}];
for m=1:size(all_tab,1)
    tmp_tab = eval(all_tab{m,1});
    if size(tmp_tab,1) == 137
        t_tab_137(end+1,1) =  all_tab(m,1);
    end
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
h = cash_surplus_deficit(:,1).Var1;
T.Properties.RowNames = h;

%fill table with all the data
%access to electricity - 2015
% for m=1:size(cash_surplus_deficit(:,60),1)
%     T(m,1) = array2table([cash_surplus_deficit{m,60}]);
% end


% cleans up most of the X by searching for older data

for n=1:size(all_tab,1)
    for m=1:size(cash_surplus_deficit,1)
        tab = eval(all_tab{n,1});
        match_nan = 1;
        counter = size(tab,2);
        while (match_nan && counter >= 5)
            if (~iscell(tab{m,counter}))
                if (isnan(tab{m,counter}))
                    counter = counter -1;
                    if (counter == 4), T(m,n) = table(nan); end
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

%% treat data with 137 countries - South Sudan is not present!
data = zeros(137,size(t_tab_137,1));
T2 = array2table(data);
h = t_tab_137(:,1);
T2.Properties.VariableNames = h;
T2.Properties.RowNames = armed_forces_total{:,3};
for m=1:size(T2,1)
    match_nan = 1;
    counter_tourism = 19;
    counter_pc = 34;
    
    while (match_nan && counter_tourism > 5 )
        if (~iscell( str2double(strrep(armed_forces_total{m,counter_tourism},',','')) ))
            if (isnan( str2double(strrep(armed_forces_total{m,counter_tourism},',','')) ))
                counter_tourism = counter_tourism - 1;
                if (counter_tourism == 4), T2(m,n) = table(nan); end
                
            else
                T2(m,1) = array2table(str2double(strrep(armed_forces_total{m,counter_tourism},',','')));
                match_nan = 0;
                break;
            end
        end
    end
    match_nan = 1;
    %     while (match_nan && counter_pc > 5 )
    %         if (~iscell( apple_prod{m,counter_pc} ))
    %             if (isnan( apple_prod{m,counter_pc} ))
    %                 counter_pc = counter_pc - 1;
    %             else
    %                 T2(m,2) = array2table(apple_prod{m,counter_pc});
    %                 match_nan = 0;
    %                 break;
    %             end
    %         end
    %     end
    
    %     match_nan = 1;
    %     counter_pc = 10;
    %     while (match_nan && counter_pc > 5 )
    %         if (~iscell( str2double(strrep(time_to_prepare_pay_taxes{m,counter_pc},',','')) ))
    %             if (isnan( str2double(strrep(time_to_prepare_pay_taxes{m,counter_pc},',','')) ))
    %                 counter_pc = counter_pc - 1;
    %             else
    %                 T2(m,3) = array2table( str2double(strrep(time_to_prepare_pay_taxes{m,counter_pc},',',''))/100 );
    %                 match_nan = 0;
    %                 break;
    %             end
    %         end
    %     end
    
end

for m=1:size(t_tab_137,1)
    tmp_tab = eval(t_tab_137{m,1});
    counter_tab = size(tmp_tab,2); % counter for nan elimination
    match_nan = 1;
    for n=1:size(tmp_tab,1)
        while (match_nan && counter_tab > 5 )
            if (~isnumeric(tmp_tab{n,counter_tab}))
                if ( isnan( str2double(strrep(tmp_tab{n,counter_tab},',','')) ) )
                    counter_tab = counter_tab - 1;
                    if (counter_tab == 4), T2(m,n) = table(nan); end
                else
                    T2(n,m) = array2table( str2double(strrep(tmp_tab{n,counter_tab},',','')) );
                    match_nan = 0;
                    break;
                end
                
            end
            if (isnumeric(tmp_tab{n,counter_tab}))
                if (isnan(tmp_tab{n,counter_tab}))
                    counter_tab = counter_tab - 1;
                else
                    T2(n,m) = array2table( tmp_tab{n,counter_tab} );
                    match_nan = 0;
                    break;
                end
            end
        end
        match_nan = 1;
        counter_tab = size(tmp_tab,2);
    end
end

tmp_sudan = array2table(NaN(1,4));
tmp_sudan.Properties.VariableNames = h;
tmp_sudan.Properties.RowNames = cash_surplus_deficit{114,1};
T2 = [T2;tmp_sudan];
T2(115:end,:) = T2(114:137,:);
T2.Properties.RowNames = cash_surplus_deficit{:,1};
T2(114,:) = tmp_sudan;

% T2(115:138) = T();
X = array2table(zeros(138,9));
h = [T.Properties.VariableNames T2.Properties.VariableNames];
X.Properties.VariableNames = h;
X.Properties.RowNames = T.Properties.RowNames;

X(:,1:5) = T;
    X(:,6:end) = T2;
%replace 0 with NaN
for m=7:size(X,2)
    for n=1:size(X,1)
        if (X{n,m} == 0)
            X(n,m) = table(nan);
        end
    end
end
    
    
    
