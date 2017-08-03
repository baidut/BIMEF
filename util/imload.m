function I = imload(I, varargin)
%IMLOAD Load an image.

%TODO
%IMNORM Load an normalized image

if nargin == 0
    if nargout == 0 % demo
        imgFile = 'cameraman.tif';
        raw = imread(imgFile);
        bigger = imload(imgFile, 'minSize', 1280);
        smaller = imload(imgFile, 'maxSize', 50);
        subplot(221); imagesc(raw);       title('Raw Image (uint8)');
        subplot(222); imagesc(bigger);    title('Set minSize to 1280');
        subplot(223); imagesc(smaller);   title('Set maxSize to 50');
        return;
    else
        %I = imload(imgetfile)
        %return;
        I = imgetfile;
    end
end

default.maxSize = globalVar('imload_maxSize', 480);
default.minSize = globalVar('imload_minSize', 0);
default.gpu = false;
default.roi = [];
default.medfilt2 = false;

param = ezInput(varargin, default);

if ischar(I)
    fileName = I;
    [path, name, ext] = fileparts(fileName);
    if strcmp(ext,'') || ~isempty(strfind(name, '*'))
        [filename, pathname] = uigetfile(fileName);
        fileName = fullfile(pathname, filename);
    end
    
    try
        I = imread(fileName);
    catch
        fileName = fullfile(globalVar('imgPath', cd), fileName);
        I = imread(fileName);
    end
    fileName,
    globalVar('fileName', fileName); % not full file
end

%% Roi
if ~isempty(param.roi)
    I = I(param.roi{1}, param.roi{2}, :);
end

%% Gpu Speedup
if param.gpu
    I = gpuArray(I);
    disp('gpu on.');
end

%% Preprocessing
% denoise
% 中值滤波等放在im2double +eps 前做，否则有很多麻烦，resize 和  medfilt2 都会引入负数
if param.medfilt2
    filter = @(x)cat(3,medfilt2(x(:,:,1)),medfilt2(x(:,:,2)),medfilt2(x(:,:,3)));
    % I(I<0) = 0; % avoid being complex
    I = filter(I);
end

%% Resizing
% It will be too time-consuming to process a large image, so resize it first.
assert(param.maxSize>=0);
if param.maxSize
    len = max(size(I));% length
    if len > param.maxSize
        I = imresize(I, param.maxSize./len);
        [nRow, nCol, ~] = size(I);
        fprintf('image resized to (%dx%d) for saving speed.\n',nRow, nCol);
    end
end
assert(param.minSize>=0);
if param.minSize
    len = max(size(I));% length
    if len < param.minSize
        I = imresize(I, len./param.minSize);
        [nRow, nCol, ~] = size(I);
        fprintf('image is too small, resized to (%dx%d).\n',nRow, nCol);
    end
end

%% Normalization
I = max(I, 0);      % avoid resulting complex value when sqrt
I = im2double(I);   % normalized to [0 1]
I = I + eps;        % avoid resulting Inf value when log(I) or []./I

end