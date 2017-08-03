function h = ezFig(varargin)
%ezFig help you show figure with images easily

if nargin == 0
    showhelp
    % ezFig('peppers.png', 'cameraman.tif', 'football.jpg');
    disp 'Example 1 - command-like usage. Press any key to start.'
    pause;
    I = imread('football.jpg');
    ezFig ''peppers.png''  [] cameraman.tif 'football.jpg' I I./2
    
    disp 'Example 2 - function-like usage. Press any key to start.'
    pause
    ezFig('peppers.png', ezAxes('cameraman.tif', 'football.jpg'));
    
    disp 'Example 3 - layout configuration. Press any key to start.'
    pause;
    cfg.layout = [1 1 0
        2 2 3
        4 4 4];
    ezFig(cfg, 'peppers.png', 'cameraman.tif', 'pout.tif', 'football.jpg');
    return;
end

names = arrayfun(@inputname,1:numel(varargin),'uniformoutput',false);
args = struct('name',names,'value', varargin);

%% cfg

if isstruct(varargin{1})
    cfg = varargin{1};
    args = args(2:end);
else
    cfg = struct;
end

default.interpreter = globalVar('ezFig_interpreter', 'tex');
default.titleFormat = globalVar('ezFig_titleFormat', '%name'); % %name\color{blue}<%class>
cfg = loaddefault(cfg, default);

if isfield(cfg, 'layout')
    mat = cfg.layout;
    [r, c] = size(mat);
    mat = mat'; mat = mat(:); % convert to a vector
else
    narg = numel(args);
    r = floor(sqrt(narg));
    c = ceil(narg/r);
end

%% main
n = 0;
% h = gcf;
h = figure; % default: new figure
for arg = args, n = n + 1;
    if isempty(arg.value) || strcmp(arg.value, '[]'); continue; end 
    
    % first setup new subplot to allow some function eg. hist
    if isfield(cfg, 'layout')
        pStart = find( mat==n, 1, 'first');
        pEnd =  find( mat==n, 1, 'last');
        subplot(r, c, [pStart pEnd]);
    else
        subplot(r, c, n);
    end
    
    if isempty(arg.name)
        if ischar(arg.value) % expression or 'image.jpg'
            arg.name = arg.value;
            try
                %if 2 == exist(arg.value, 'file') % image file
                    arg.value = imread(arg.name); % not necessary
                %end
            catch % expression
                if arg.value(1) == '(' && arg.value(end) == ')'
                    evalin('caller', arg.value);
                else
                    arg.value = evalin('caller', arg.value);
                end
            end
        end
        %TODO: if isobject try char(object)
    end
    
    % arg.value can be: image, imagefilename, object
    try
        %if ~isvector(arg.value) % imhist
        imshow(arg.value);
        %end
    catch % more robust % allow histogram
    end
    %title(arg.name);
    if ~strcmp(cfg.interpreter, 'none')
        arg.name = strrep(arg.name, '_', '\_');
    end
    
    text = strrep(cfg.titleFormat, '%name', arg.name);
    text = strrep(text, '%class', class(arg.value));
    title(text, 'Interpreter', cfg.interpreter);
end

if nargout == 0, clear h; end

%TODO: adaptive layout according to image size
%
% f = Fig(args); h = f.handle;
%
% if isstruct(cfg)
%     if isfield(cfg, 'layout')
%         f.setLayout(cfg.layout);
%     end
% end
%
% disp(f);
