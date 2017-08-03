function results = eachfile(filenames, func, varargin)
%EACHFILE Execure function for each specified file.
%   results = eachfile(filenames, func, params)
% is same as:
%   for-loop: results{n} = func(file{n}, params{:})
% if no func is given, then output column filenames.
%
% Example
%
%   % Display files in a folder
%   files = '%datasets/SLD2011\dataset3\sequence\01*.jpg';
%  	eachfile(files); %eachfile(files,@disp);
%
%   % Get file names
%  	filename = eachfile(files);
%   montage(filename(1:2:end));
%
%   % Display pictures in a folder
%  	eachfile(files,@imshow);
%
%   % Snapshot pictures.
%  	images = eachfile(files,@imread);
%   montage(cat(4,images{:}));
%
%   % Cmd-like usage
%   eachfile *.png @delete
%
% See more https://github.com/baidut/OpenVehicleVision/issues/46
% LOG 2016-08-20 add linux support

% check inputs
validateattributes(filenames,{'char', 'cell'},{'nonempty'});
if nargin < 2
   func = @(x)x;
end

% validateattributes(func,{'function_handle'},{'nonempty'});
switch class(func)
    case 'function_handle'
    case 'char'
        func = str2func(func);
    otherwise
        error('unkown input types');
end


% eachfile('peppers.png');
if  ischar(filenames) && ~ismember('*', filenames) && isempty(fileparts(filenames))
    results = {func(which(filenames))};
    return;
end


%% 
% See doc dir
% To exclude invalid entries returned by the dir command, use the cellfun function.
% MyFolderInfo = dir; 
% MyFolderInfo = MyFolderInfo(~cellfun('isempty', {MyFolderInfo.date})); 

if iscell(filenames)
    files = filenames;
    nameFolds = filenames;
else
    % gen full path
    if 0 ~= exist('GetFullPath','file') % 2 or 3
        filenames = GetFullPath(filenames);
    end

    % get files
    if ~isdir(filenames)
        path = fileparts(filenames);
    else
        path = (filenames);
    end
    
    d = dir(fullfile(filenames));
    
    d = d(~cellfun(@(x)x, {d.isdir})); % exclude subfolder and <.> <..>
    d = d(~cellfun(@(x)x(1)=='.', {d.name})); % exclude mac files '._xxx.jpg'
    d = d(~cellfun('isempty', {d.date}));  %  exclude invalid entries
    
    nameFolds = {d.name}';

%     if isempty(ext) && isempty(name)  % 1: <.> 2: <..>
%         nameFolds = nameFolds(3:end);
%     end
    if ~isempty(path)
        files = strcat([path filesep],nameFolds);
    else
        files = nameFolds;
    end
end

% exec function
f = @(x)func(x,varargin{:});

if nargout == 0
    %cellfun(f, files, 'UniformOutput',false);
    for n = 1:numel(files) 
		fprintf('%3d %% <%s> ... \n', uint8(100*n/numel(files)), nameFolds{n});
        f(files{n});
		disp ok
    end
else
    %cellfun is slower than for-loop
    %slower: results = cellfun(f, files, 'UniformOutput',false);
    %faster: for-loop
    results = cell(numel(files), 1); 
    for n = 1:numel(files)
        results{n} = f(files{n});
    end
end