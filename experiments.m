startup

% specify your paths to the datasets
name = {'VV' 'LIME' 'NPE' 'NPE-ex1' 'NPE-ex2' 'NPE-ex3' 'MEF' 'DICM'};
dataset = strcat('data', filesep, name, filesep, '*.*');

% specify methods and metrics
method = {@multiscaleRetinex @dong @npe @lime @mf @srie @BIMEF};
metric = {@loe100x100}; 
% metric = {@loe100x100 @vif}; % NOTE matlabPyrTools is required to run VIF metric (vif.m).

for n = 1:numel(dataset); data = dataset{n};
    data,  
    Test = TestImage(data);        
    Test.Method = method; 
    Test.Metric = metric;
    
    % run test and display results
    Test,                     
    
    % save test to a .csv file
    save(Test); % %save(Test, ['TestReport__' name{n} '.csv']);
end