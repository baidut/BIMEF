classdef TestReport
    
    properties
        Data
    end
    
    properties (Dependent)
        Method
        Metric
    end
    
    methods
        function this = TestReport(data)
            %import CE.TestReport
            if nargin == 0 && nargout == 0
                file = '#dataset\#lowlight\VV\out\TestReport.csv';
                t = TestReport(file);
                disp(t);
                toTex(t);
                clear; return;
                
                %writetable(t.Data, 'TestReport.csv');
                
                % data extraction
                t1 = t(2:5,3:6);
                t2 = t(2:5,7:end);
                t3 = t(6:8,7:end);
                
                t1, t2, t3
                
                % data merge
                t12 = [t1 t2];
                t23 = [t2;t3];
                
                t12, t23
                clear; return;
                return;
            end
            
            if nargin == 0
                [filename, pathname] = uigetfile( {
                    '*.txt;*.csv', 'Table'
                    '*.*',  'All Files (*.*)'}, ...
                    'Pick a file', 'MultiSelect', 'on');
                data = strcat(pathname, filename);
            end
            if ischar(data)
                if exist(data, 'file'), data = readtable(data);
                else error('File Not Found!');
                end;
            end
            this.Data = data;
            %this.sorttable();
        end
    end
    
    methods
        function method = get.Method(this), method = this.Data{1:numel(unique(this.Data.Method)),2}'; end
        function metric = get.Metric(this), metric = this.Data.Properties.VariableNames(3:end); end
    end
    
    methods
        function M = height(this), M = numel(this.Method); end
        function N = width(this), N = numel(this.Metric); end
        function t = table(this), t = this.Data; end
        %function text = tex(this), ; end % latex
        
        function disp(this), disp(summary(this)); end
    end
    
    %% ------ Data display ------
    methods
        function [meanTable, stdTable] = summary(this)
            % check
            M = height(this);
            N = width(this);
            
            meanScore = zeros(M, N);
            stdScore = zeros(M, N);
            for m = 1:M
                data = this.Data{m:M:end,end-N+1:end};
                meanScore(m,:) = mean(data, 1);
                stdScore(m,:) = std(data, 0, 1);
            end
            sumTable = this.Data(1:M, 3:end);
            sumTable.Properties.RowNames = this.Data{1:M, 2};
            meanTable = sumTable;
            stdTable = sumTable;
            meanTable{:,:} = meanScore;
            stdTable{:,:} = stdScore;
        end
        
        % boxplot(Test.Report, {'Run Time (1600x1200)'} ,'Labels', {'Fu', 'HE-RGB', 'HE-Lab'})
        function boxplot(this, metricName, varargin)
            M = width(this);
            r = floor(sqrt(M));
            c = ceil(M/r);
            if ~exist('metricName', 'var'), metricName = this.Metric; end
            for m = 1:M
                subplot(r,c, m); % figure, %
                boxplot(this.Data{:,2+m},this.Data{:,2}, varargin{:});
                title(metricName{m});
                xlabel Methods
                ylabel Score
            end
        end
        
        function latex = toTex(this)
            % show mean only [default]
            % show mean+var
            Require ..\3rdparty\latexTable
            
            meanTable = summary(this);
            % Now use this table as input in our input struct:
            input.data = meanTable;
            
            % Set the row format of the data values (in this example we want to use
            % integers only):
            input.dataFormat = {'%.2f'};
            
            % Column alignment ('l'=left-justified, 'c'=centered,'r'=right-justified):
            input.tableColumnAlignment = 'c';
            
            % Switch table borders on/off:
            input.tableBorders = true;
            
            % Switch to generate a complete LaTex document or just a table:
            input.makeCompleteLatexDocument = false;
            
            % Now call the function to generate LaTex code:
            latex = latexTable(input);
        end
        
        function plot(this, method, metric, varargin)
            % test.Report.plotxy({@(x)x, @ours}, @AB);
            y = zeros( height(this.Data)/height(this), numel(method));
            for n = 1:numel(method)
                y(:,n) = this.Data{find(strcmp(char(method{n}), this.Method)):height(this):end, ...
                    [false false strcmp(char(metric), this.Metric)]};
            end
            y = sortrows(y);
            plot(y, varargin{:});
        end
    end
    
    %% ------ Data extraction ------
    methods
        function ind = end(this,k,n)
            szd = [height(this), width(this)];
            if k <= n
                ind = szd(k);
            else
                error undefinedEndIndexing
                ind = prod(szd(k:end));
            end
        end
        function varargout = subsref(this,s)
            %import CE.TestReport
            switch s(1).type
                case '()'
                    if length(s) == 1 % Implement this(indices)
                        A = reshape(1:height(this.Data), height(this), []);
                        s.subs{1} = A(s.subs{1},:);
                        if ~ischar(s.subs{2}), s.subs{2} = [1,2,s.subs{2}+2]; end
                        varargout = {TestReport(builtin('subsref',this.Data,s))};
                    else
                        varargout = {builtin('subsref',this,s)};
                    end
                otherwise
                    %varargout = {builtin('subsref',this,s)}; % only one
                    [varargout{1:nargout}] = builtin('subsref',this,s);
                    %error('Not a valid indexing expression')
            end
        end
    end
    %% ------ Data merge ------
    methods (Access = private)
        function result = merge(this, oper, inputs) % private
            N = numel(inputs);
            tables = cell(1,N);
            for n = 1:N
                tables{n} = inputs{n}.Data; %TestReport(inputs{n}).Data;
            end
            % assert tables have the same size
            result = TestReport(oper(this.Data, tables{:}));
        end
        
        function this = sorttable(this)
            this.Data = sortrows(this.Data,{'File','Method'},{'ascend','ascend'});
            %this.Data = sortrows(this.Data,{'File'},{'ascend'});
        end
    end
    methods
        function result = horzcat(this, varargin)
            result = merge(this, @join, varargin); %horzcat table 不允许重复的变量名称
        end
        
        function result = vertcat(this, varargin) % handle
            result = merge(this, @vertcat, varargin);
            result = result.sorttable;
        end
    end
end

