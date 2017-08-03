function [lightOrderError, mask] = loe100x100(raw, enhanceResult)
% function lightOrderError = calLightOrderError(raw, enhanceResult)

if nargin == 0
%     I = imread(imgetfile);
%     loe1 = loe100x100(I, imread(imgetfile))
%     loe2 = loe100x100(I, imread(imgetfile))
%     return;
    
    I = imload(imgetfile);
    loe1 = loe100x100(I, ours_K(I))
    loe2 = loe100x100(I, n(I))
    %loe_npe = loe100x100(I, npe(I))
    return;
    
%     raw = imread('#dataset\#new\ColourCharts\IMG002.tiff');
%     enhanceResult = imread('#dataset\#new\ColourCharts\IMG002__he.PNG');
    raw = imload(imgetfile);
    enhanceResult = imload(imgetfile);
    tic
    [lightOrderError, mask]= loe100x100(raw, enhanceResult);
    toc
    ezFig raw enhanceResult mat2gray(mask)
    return
end

assert(nargin == 2);

% resize
raw = im2uint8(raw); % imresize(raw,[100 100])
enhanceResult = im2uint8(enhanceResult); % imresize(enhanceResult,[100 100])

rawL = max(raw,[],3);
[nRow, nCol] = size(rawL);

enhanceResultL = max(enhanceResult,[],3);

N = 100;
sampleRow = round( linspace(1,nRow,N) ); % 100 samples
sampleCol = round( linspace(1,nCol,N) );
rawL = rawL(sampleRow, sampleCol); % downsample
enhanceResultL = enhanceResultL(sampleRow, sampleCol);

error = 0;
mask = zeros(N,N);
for r = 1:N %size(rawL,1)*size(rawL,2)   %numel(rawL)
    for c = 1:N
        mapRawOrder = rawL>=rawL(r,c);
        mapResultOrder = enhanceResultL>=enhanceResultL(r,c);
        mapError = xor(mapRawOrder,mapResultOrder);
        error = error + sum(mapError(:));
        mask(r,c) = sum(mapError(:));
    end
end

%% save mask to file
fileName = globalVar('TestImage_resultFile', 'tmp'); % Test_resultFile
dirname = rename(fileName, '<path>/loe100x100');
if ~exist(dirname,'dir'), mkdir(dirname); end
figure; imshow(mask./5000, 'Border','tight','InitialMagnification',500); % colormap jet
print(gcf, rename(fileName, '<path>/loe100x100/loe100x100_<name>'), '-djpeg'); close(gcf);


lightOrderError = error / (N*N); %(size(raw,1)*size(raw,2));

end
