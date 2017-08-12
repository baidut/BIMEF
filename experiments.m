% specify your paths to the datasets
dataset = {'VV' 'LIME' 'NPE' 'NPE-ex1' 'NPE-ex2' 'NPE-ex3' 'MEF' 'DICM'};
dataset = strcat('data', filesep, dataset, filesep, '*.*');

% specify methods and metrics
method = {@multiscaleRetinex @dong @npe @lime @mf @srie @BIMEF};
metric = {@loe100x100 @vif};

for d = dataset, data = d{1};
    data,  
    Test = TestImage(data);        
    Test.Method = method; 
    Test.Metric = metric;
    
    % run test and display results
    Test,                     
    
    % save test to a .csv file
    save(Test);
end