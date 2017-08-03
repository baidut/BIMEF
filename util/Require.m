classdef Require < handle
    %REQUIRE manage dependency.
    % Instead of using:
    %
    %     required = {'path1', 'path2', 'path3'};
    %     addpath(required{:});
    %     % do something
    %     rmpath(required{:});
    %
    % Just use single line:
    %     
    %     r = Require('path1', 'path2', 'path3');
    % Or
    %     Require('path1', 'path2', 'path3');
    %
    % The required path will be removed automatically.
    % To remove the path mannully:
    %
    %    clear r;
    %
    % If you wana add path permenately, use `addpath` and `savepath`
    % instead.
    %
    % Add requirement in matlab cmd window: require folder1 folder2
    % the requirement will be removed automatically when ans is replaced or
    % cleared.  
    
    properties
        path = {}
        fprintf
    end
    methods
        function this = Require(varargin)
            if nargout == 0 % be quiet, no information out
                this.fprintf = @(varargin)[];
            else
                this.fprintf = @fprintf;
            end
            
            % this.path = varargin;
            % addpath(this.path{:});
            inputPath = strjoin(varargin, ';');
            pathList = strsplit(inputPath, ';');
            
            %% 
            try
                caller = callerFile;
                defaultPath = caller.path;
            catch
                defaultPath = cd;
            end
            
            for pathStr = pathList
               [p, func] = strsplit(pathStr{1}, '>');p = p{1};
               if ~ismember(':', p) % is not fullpath
                   p = [defaultPath filesep p];
               end
               if isempty(func) || ~exist(func{1}, 'file')
                   addpath(p);
                   this.path{end+1} = p;
               end
            end
            %ezPath(struct('SavePath', false), varargin{:});
            this.fprintf('<strong>Requirement Added.</strong>\n%s\n', strjoin(this.path,'\n'));
        end
        function delete(this)
            this.fprintf('<strong>Requirement Removed.</strong>');
            if ~isempty(this.path), rmpath(this.path{:}); end
        end
        function add(this, varargin)
            addpath(varargin{:});
            this.path = [this.path, varargin];
        end
        function save(this)
            savepath % what about other Require?
            this.path = {};
        end
        function disp(this)
            this.fprintf('%s\n', this.path{:});
        end
    end
end