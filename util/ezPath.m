function oldPath = ezPath(varargin)
%EZPATH add path more easier.
%USAGE
% ezPath folder1 folder2 ...

%SEE ALSO addpath rmpath savepath
%
%COPYRIGHT Zhenqiang Ying <yingzhenqiang-at-gmail-dot-com>

oldPath = path;

cfg.SavePath = true;
cfg.FullPath = true;

if isstruct(varargin{1})
	cfg = loaddefault(varargin{1}, cfg, true); % time-consuming
    varargin = varargin(2:end);
end

inputPath = strjoin(varargin, ';');
pathList = strsplit(inputPath, ';');

try
    caller = callerFile;
    defaultPath = caller.path;
catch
    defaultPath = cd;
end

if cfg.FullPath
    for pathStr = pathList
        [p, func] = strsplit(pathStr{1}, '>');p = p{1};
        if ~ismember(':', p) % is not fullpath
            p = [defaultPath filesep p];
        end
        if isempty(func) || ~exist(func{1}, 'file')
            if p(end) == '*'
                genpath(p(1:end-1))
                addpath(genpath(p(1:end-1)));
            else
                addpath(p);
            end
            %this.path{end+1} = p;
        end
    end
else
    addpath(inputPath);
end

if cfg.SavePath
	savepath
end