% t = TempDir
% t = ThisDir

classdef Cd < handle % delete
    %CD change current folder temporarily
    % dir = Cd;
    % dir = Cd('your_tmp_path');

    properties
        path % old path
    end
    methods
        function this = Cd(path)
            caller = callerFile;
            curPath = caller.path;
            if nargin == 0
                path = curPath;
            end
            this.path = cd;
            cd(strrep(path, './', [curPath, '/']));
            %fprintf('Current Folder Changed to %s Temporarily.\n', path);
        end
        function delete(this)
            cd(this.path);
            %fprintf('Current Folder Changed Back.\n') 
        end
        function s = char(this)
        % dir = Cd;
        % fprintf('%s\n', dir);
            s = this.path;
        end
    end
end