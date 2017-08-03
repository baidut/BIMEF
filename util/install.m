function install(your_dir)

if nargin == 0
    your_dir = 'E:\shared\Matlab'; % '\\-BAIDUT\shared\Matlab'; %
end

% install datasets, includes
if 7~=exist('#dataset','dir')
    disp 'Installing ...'
    %dir = callerFile('path');
    runasadmin(sprintf('mklink /D "#dataset" "%s/#dataset"\nmklink /D "#include" "%s/#include"', your_dir, your_dir));
    disp ok
else
    disp 'Already Installed'
end

end

% use %% instead of % since % is special char in batch file
% mklink /D ".\%%datasets" E:\Sync\my\project\datasets