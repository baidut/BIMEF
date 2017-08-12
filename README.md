# BIMEF

![](https://img.shields.io/badge/MATLAB-R2016b-green.svg) 

![](https://img.shields.io/badge/OS-Win10-green.svg) 

Code for our paper "A Bio-Inspired Multi-Exposure Fusion Framework for Low-light Image Enhancement"

* The code for the comparison method is also provided
* Since some methods are quite time-consuming, we also provide their results
* All the experiments can be reproduced easily by running `experiments.m`

## Datasets

- [VV](https://sites.google.com/site/vonikakis/datasets) （**Busting image enhancement and tone-mapping algorithms: **A collection of the most challenging cases）
- [LIME-data](http://cs.tju.edu.cn/orgs/vision/~xguo/LIME.htm)
- [NPE-data, NPE-ex1, NPE-ex2, NPE-ex3](http://blog.sina.com.cn/s/blog_a0a06f190101cvon.html)
- DICM —— 69 captured images from commercial digital cameras: [Download (15.3 MB)](http://mcl.korea.ac.kr/projects/LDR/LDR_TEST_IMAGES_DICM.zip)
- [MEF](https://ece.uwaterloo.ca/~k29ma/)  [dataset](http://ivc.uwaterloo.ca/database/MEF/MEF-Database.php)

In case the link provided above is not available, you can download my copy from [here](https://drive.google.com/drive/folders/0B_FjaR958nw_djVQanJqeEhUM1k?usp=sharing).

## Downloads

https://drive.google.com/drive/folders/0B_FjaR958nw_djVQanJqeEhUM1k?usp=sharing

Just unzip data to current folder :)

## Setup

Run `startup.m`

Note [matlabPyrTools](https://github.com/gregfreeman/matlabPyrTools) is required to run VIF metric (`vif.m`).

## Demo

```matlab
I = imread('yellowlily.jpg');
J = BIMEF(I); 
subplot 121; imshow(I); title('Original Image');
subplot 122; imshow(J); title('Enhanced Result');
```

## Usage

To reproduce our experiments, run `experiments.m`

```matlab
% specify your paths to the datasets
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
```



