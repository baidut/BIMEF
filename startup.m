function startup
persistent done

if isempty(done)
    clear global
    userpath(pwd)
    
    addpath(pwd, genpath([pwd, '\util']));
    ezPath lowlight quality
    
    savepath
    
    dbstop if error
    done = 1;
end