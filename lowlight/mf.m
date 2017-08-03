function [output] = mf(input)
% A wrapper of MF (Multi-deviation Fusion method)
% 
% -------------------------------------------------------------------------
% @article{fu2016mf,
%   title={A fusion-based enhancing method for weakly illuminated images},
%   author={Fu, Xueyang and Zeng, Delu and Huang, Yue and Liao, Yinghao and Ding, Xinghao and Paisley, John},
%   journal={Signal Processing},
%   volume={129},
%   pages={82--96},
%   year={2016},
%   publisher={Elsevier}
% }
% -------------------------------------------------------------------------
%
% OpenCE https://github.com/baidut/OpenCE
% Author: Zhenqiang Ying
% 2017-5-12

if nargin == 0
   I = imload; % imread('yellowlily.jpg'); %
   J = mf(I);
   ezFig(I,J);
   return;
end

Require MF

if ~isfloat(input), input = im2double(input); end
if isfloat(input), input = (input)*255; end

output = multi_fusion(input);
end