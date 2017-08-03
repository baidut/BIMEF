function visualComparison


% close all;
% methodNames = {'lime' 'npe' 'mf' 'srie' 'ours_caip2017'};
% xywh = [
%    143   276   215    66
%     ];
% show_methods_roi('#dataset\#lowlight\LDR_TEST_IMAGES_DICM\12.JPG', xywh, methodNames,...
%     '%(path)/out/%(name)__%(method).PNG');
% 
% return;
%% Visual Comparison
% files = {
%     '#dataset\#lowlight\MEFDatabase\BelgiumHouse.png'
%     '#dataset\#lowlight\NPE-ex\Part I\cloudy (1)_bmp.bmp'
% %     '#dataset\#lowlight\NPE-ex\Part I\cloudy (6)_bmp.bmp'
% %     '#dataset\#lowlight\NPE-ex\Part I\cloudy (16)_jpg.jpg'
%     '#dataset\#lowlight\LDR_TEST_IMAGES_DICM\27.JPG'
%     '#dataset\#lowlight\LDR_TEST_IMAGES_DICM\36.JPG'
%     };
% files = {
%     '#dataset\#lowlight\tcyb\13.jpg'
% };
files = eachfile('#dataset\#lowlight\tcyb\*.jpg');

Test.OutDir = '<data>/out';
Test.OutName = '<file>__<algo>.jpg';
Test.Method = {'multiscaleRetinex' 'dong' 'npe' 'lime' 'mf' 'srie'  'ours_caip2017'};  % 'dheci'
% Test.Method = {'he_lab' 'clahe_lab' 'wahe' 'cvc' 'ldr' 'rpce' 'dheci' ...
%     'multiscaleRetinex' 'lime' 'dong' 'npe' 'mf' 'srie' 'ours_caip2017'}; % 'wahe'

N = numel(files);
M = numel(Test.Method);
eg = cell(1, N);
img = cell(1, M);

for n = 1:N, file = files{n};
    outDir = strrep(Test.OutDir, '<data>', fileparts(file));
    for m = 1:M, method = Test.Method{m};
        [~, name, ext] = fileparts(file);
        outName = strrep(Test.OutName, '<file>',  name);
        outName = strrep(outName,      '<ext>',   ext(2:end));
        outName = strrep(outName,      '<algo>',  char(method));
        outFile = [outDir filesep outName];
        if ~exist(outFile, 'file')
            fprintf('regenerate file %s', outFile);
            f = str2func(method);
            res = f(imread(file));
            imwrite(res, outFile);
        end
        img{m} = loadImage(outFile);
    end
    
    raw = loadImage(file);
    
    eg{n} = horzcat(raw, img{:});
end

iccvw_more = vertcat(eg{:});
% imshow( vertcat(eg{:}), 'border', 'tight');
ezDump(iccvw_more);

end

function img = loadImage(file)

width = 500;
img = imread(file);
img = imresize(img, [NaN width]);
img = padarray(img, [5 5], 255, 'both');

end