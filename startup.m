function startup

clear global 
userpath(pwd)

addpath(pwd, genpath([pwd, '\util']));

ezPath gray color ...
       denoise lowlight underwater ...
       ui labelTool ...
       vis video ...
       quality ...
       samples

savepath

dbstop if error

