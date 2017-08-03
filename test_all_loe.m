function test_all_loe 
dataset = { ...
    '#dataset\#lowlight\LIME\*.bmp', ...
    '#dataset\#lowlight\NPE\*.*', ...
    '#dataset\#lowlight\MEFDatabase\*.png', ...
    '#dataset\#lowlight\NPE-ex\Part I\*.*', ... 
    '#dataset\#lowlight\NPE-ex\Part II\*.*', ... 
    '#dataset\#lowlight\NPE-ex\Part III\*.jpg', ... 
    '#dataset\#lowlight\LDR_TEST_IMAGES_DICM\*.JPG', ...
	'#dataset\#lowlight\VV\*.jpg', ...
};
clc
% 
%% display test
method = {@multiscaleRetinex @dong @npe  @lime @mf @srie @ours_caip2017}; %  @rpce
metric = {@loe100x100}; % HIGRADE1

for d = dataset, data = d{1};
    data,  
    Test = TestImage(data);        
    Test.Method = method; 
    Test.Metric = metric;
    Test,
    % DO NOT SAVE!!!!!
end

return;

%% run test
method = {@ours_caip2017 @ours_mm2017 @srie  @mf @lime @npe @dong @multiscaleRetinex @amsr @dheci @bpdhe }; %  @rpce @cvc @ldr
metric = {@loe100x100 @il_niqe @biqme @niqe @brisque @vsnr @fsim @ssim @msssim @iwssim @ifc @vif @vifp @vif_r @mad @VSI @HIGRADE2 @RIQMC}; % HIGRADE1


for d = dataset, data = d{1};
    data,  
    Test = TestImage(data);        
    Test.Method = method; 
    Test.Metric = metric;
    Test,
    save(Test);
end





return;
metric = [{@deltaE} metric];
dataset = { ...
    '#dataset\#lowlight\UEA\*.tiff', ...
    '#dataset\#lowlight\NUS\*.jpg', ...
};

for d = dataset, data = d{1};
    data,  
    Test = TestImage(data);        
    Test.Method = method; 
    Test.Metric = metric;
    Test,
    save(Test);
end

end