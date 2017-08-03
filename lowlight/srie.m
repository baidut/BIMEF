function [enhanced_result, R, L] = srie(input_image)
% A wrapper of SRIE (Simultaneous Reflection and Illumination Estimation)
% 
% -------------------------------------------------------------------------
% @inproceedings{fu2016srie,
%   title={A weighted variational model for simultaneous reflectance and illumination estimation},
%   author={Fu, Xueyang and Zeng, Delu and Huang, Yue and Zhang, Xiao-Ping and Ding, Xinghao},
%   booktitle={Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition},
%   pages={2782--2790},
%   year={2016}
% }
% -------------------------------------------------------------------------
%
% OpenCE https://github.com/baidut/OpenCE
% Author: Zhenqiang Ying
% 2017-5-11

if nargin == 0
   I = imread('yellowlily.jpg'); %imload;
   [J, R, L] = srie(I);
   ezFig(I,J,R,L);
   return;
end

Require SRIE

if ~isfloat(input_image), input_image = im2double(input_image); end

img = 255*input_image; 

if size(img,3)>1
    HSV = rgb2hsv(img);   % RGB space to HSV  space
    S = HSV(:,:,3);       % V layer
else
    S = img;              % gray image
end


c_1 = 0.01; c_2 = 0.1; lambda = 1;     % set parameters

epsilon_stop = 1e-3;  % stopping criteria

[ R, L, epsilon_R, epsilon_L ] = processing( S, c_1, c_2, lambda, epsilon_stop );


%%% Gamma correction
gamma = 2.2;
L_gamma = 255 * ((L/255).^(1/gamma));
enhanced_V = R .* L_gamma;
HSV(:,:,3) = enhanced_V;
enhanced_result = hsv2rgb(HSV);  

% figure,
% subplot(2,2,1),imshow(uint8(img)), title('input image');
% subplot(2,2,2),imshow(uint8(enhanced_result)),title('Gamma correction');
% subplot(2,2,3),imshow(uint8(L)), title('estimated illumination');
% subplot(2,2,4),imshow(R), title('estimated reflectance');

L = L/255;
enhanced_result = enhanced_result/255;
end