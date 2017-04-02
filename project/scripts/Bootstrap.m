classdef Bootstrap
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
    end
    
    methods
        function obj = Bootstrap(target_filename)
            obj.loadVariables(target_filename);
        end
    end
    
    methods (Access = private)
        function obj = loadVariables(obj,target_filename)
            whr = readtable('world_happiness_report_2016/world_happiness_report_2016.csv');
            files = dir();
            folder_names = [{}];
            for m=1:size(files,1)
                if (isempty(findstr('.',files(m,1).name)))
                    folder_names(end+1,1) = cellstr(files(m,1).name);
                    filename = sprintf('%s.csv',files(m,1).name);
                    tab = readtable(sprintf('%s/%s',files(m,1).name,filename));
                    % check which countries match the whr
                    [Found, notFound] = obj.matchWHR(whr,tab);
                    Found(1,:) = [];
                    notFound(1,:) = [];
                    Found = sortrows(Found);
                    notFound = sortrows(notFound);
                    tmp_name = sprintf('%s',files(m,1).name);
                    eval([sprintf('%s = Found;',tmp_name)]);
                    eval([sprintf('%s_not_found = notFound;',tmp_name)]);
                    eval(['clear Found; clear notFound']);
                end
            end
            
            % save all variables
            
            all_vars = who('*');
            all_vars_not_found = [{}];
            m=1;
            while(m <= size(all_vars,1))
                tmp_size = size(eval(all_vars{m,1}),1);
                if (tmp_size ~= 137 && tmp_size ~= 138)
                    if (findstr('not_found',all_vars{m,1}))
                        all_vars_not_found(end+1,1) = all_vars(m,1);
                    end
                    all_vars(m,:) = [];
                    m = 1;
                end
                
                
                m = m + 1;
            end
            
            eval([sprintf('save( ''%s.mat'' ,all_vars{:,1})',target_filename)]);
            eval([sprintf('save( ''%s_not_found.mat'' ,all_vars_not_found{:,1})',target_filename)]);
        end
        
        function [Found, notFound] = matchWHR(obj, whr,tab)
            % small hack to find out in which column the name is located -
            % can be max until col. 5
            tmp_tab = tab(:,1:5);
            name_column = 1;
            for m=1:5
                dummy = strcmp(tab{:,m},'Albania');
                if (find(dummy))
                    name_column = m;
                end
            end
            
            larger_idx = 0;
            if (size(tab,1) > size(whr,1))
                larger_idx = size(tab,1);
            else
                larger_idx = size(whr,1);
            end
            
            % 1.) check which countries are in y
            Found = tab(1,:);
            notFound = tab(1,:);
            for m=1:larger_idx
                found = find(strcmp(tab{m,name_column},whr{:,2}));
                if (found)
                    Found(end+1,:) = tab(m,:);
                else
                    notFound(end+1,:) = tab(m,:);
                end
            end
        end
    end
    
end

