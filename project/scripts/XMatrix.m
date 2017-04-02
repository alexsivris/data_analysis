classdef XMatrix
    % Description coming soon...
    
    properties (Access = private)
        t_tab = [{}];
        t_tab_137 = [{}];
        all_tab;
        
        % tables with 137/138 countries
        T_138;
        T_137;
        T_X;
    end
    
    methods
        function obj = XMatrix(source_file)
            % load or variables to workspace
            load(source_file);
            obj.all_tab = who('*');
            id = find(strcmp('obj',obj.all_tab));
            all_tab_tmp = [obj.all_tab(1:id-1);obj.all_tab(id+1:end)];
            obj.all_tab = all_tab_tmp;
            
            % make them global
            for m=1:size(obj.all_tab,1)
                eval(['global ' obj.all_tab{m,1}]);
            end
            
            
            obj = obj.sortData(source_file);
            obj = obj.process138(source_file); 
            obj = obj.process137(source_file);
            obj = obj.addMissingCountry(source_file);
            obj = obj.clearZeros();
            
            
        end
        
        % public method to return the final X-matrix
        function X = getX(obj)
            X = obj.T_X;
        end
    end
    
    methods (Access = private)
        function obj = clearZeros(obj)
            for m=7:size(obj.T_X,2)
                for n=1:size(obj.T_X,1)
                    if (obj.T_X{n,m} == 0)
                        obj.T_X(n,m) = table(nan);
                    end
                end
            end
        end
        function obj = addMissingCountry(obj, source_file)
            load(source_file);
            
            tmp138 = eval(obj.t_tab{1,1});
            h = obj.t_tab_137(:,1);
            
            tmp_missing = array2table(NaN(1,size(obj.t_tab_137,1)));
            tmp_missing.Properties.VariableNames = h;
            tmp_missing.Properties.RowNames = tmp138{114,1};
            
            obj.T_137 = [obj.T_137;tmp_missing];
            obj.T_137(115:end,:) = obj.T_137(114:137,:);
            obj.T_137.Properties.RowNames = tmp138{:,1};
            obj.T_137(114,:) = tmp_missing;
            
            X = array2table(zeros(138,size(obj.all_tab,1)-1));
            h = [obj.T_138.Properties.VariableNames obj.T_137.Properties.VariableNames];
            X.Properties.VariableNames = h;
            X.Properties.RowNames = obj.T_138.Properties.RowNames;
            
            X(:,1:length(obj.t_tab)) = obj.T_138;
            X(:,length(obj.t_tab)+1:end) = obj.T_137;
            
            obj.T_X = X;
        end
        
        function obj = process137(obj, source_file)
            load(source_file);
            tmp = eval(obj.t_tab_137{1,1});
            
            data = zeros(137,size(obj.t_tab_137,1));
            T2 = array2table(data);
            h = obj.t_tab_137(:,1);
            T2.Properties.VariableNames = h;
            T2.Properties.RowNames = tmp{:,3};
            
            
            
            for m=1:size(obj.t_tab_137,1)
                tmp_tab = eval(obj.t_tab_137{m,1});
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
            
            obj.T_137 = T2;
            
        end
        function obj = process138(obj, source_file)
            load(source_file);
            % create x matrix for 138 countries
            data = zeros(size(obj.t_tab,1),138);
            T = array2table(data');
            h = obj.t_tab(:,1);
            T.Properties.VariableNames = h;
            
            %rename rows
            tmp = eval(obj.t_tab{1,1});
            h = tmp.Var1;
            T.Properties.RowNames = h;
            
            % cleans up most of the X by searching for older data
            for n=1:size(obj.t_tab,1)
                for m=1:size(tmp,1)
                    tab = eval(obj.t_tab{n,1});
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
            
            % last, assign it as a property
            obj.T_138 = T;
        end
        
        % 1.) separate variables with 137/138 countries
        function obj = sortData(obj, source_file)
            load(source_file);
            obj.all_tab = who('*');
            %remove obj entry from all_tab
            id = find(strcmp('obj',obj.all_tab));
            all_tab_tmp = [obj.all_tab(1:id-1);obj.all_tab(id+1:end)];
            obj.all_tab = all_tab_tmp;
            for m=1:size(obj.all_tab,1)
                tmp_tab = eval(obj.all_tab{m,1});
                if size(tmp_tab,1) == 137
                    obj.t_tab_137(end+1,1) =  obj.all_tab(m,1);
                end
                if size(tmp_tab,1) ~= 138
                    continue;
                else
                    obj.t_tab(end+1,1) = obj.all_tab(m,1);
                end
                
            end
        end
    end
    
end

