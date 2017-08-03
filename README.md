# BIMEF

![](https://img.shields.io/badge/MATLAB-R2016b-green.svg)![](https://img.shields.io/badge/OS-Win10-green.svg)

Code for our paper "A Bio-Inspired Multi-Exposure Fusion Framework for Low-light Image Enhancement"

* The code for the comparison method is also provided
* Since some methods are quite time-consuming, we also provide their results
* All the experiments can be reproduced easily by running `experiments.m`

## Datasets

- [VV](https://sites.google.com/site/vonikakis/datasets) （**Busting image enhancement and tone-mapping algorithms: **A collection of the most challenging cases）
- [LIME-data]( http://cs.tju.edu.cn/orgs/vision/ ∼ xguo/LIME.htm)
- [NPE-data, NPE-ex1, NPE-ex2, NPE-ex3](http://blog.sina.com.cn/s/blog_a0a06f190101cvon.html)
- DICM —— 69 captured images from commercial digital cameras: [Download (15.3 MB)](http://mcl.korea.ac.kr/projects/LDR/LDR_TEST_IMAGES_DICM.zip)
- [MEF](https://ece.uwaterloo.ca/~k29ma/)  [dataset](http://ivc.uwaterloo.ca/database/MEF/MEF-Database.php)

## Downloads

Uploading...

|       | VV   | LIME-data | NPE-data | DICM |
| ----- | ---- | --------- | -------- | ---- |
| MSRCR |      |           |          |      |
| Dong  |      |           |          |      |
| NPE   |      |           |          |      |
| LIME  |      |           |          |      |
| MF    |      |           |          |      |
| SRIE  |      |           |          |      |
| Ours  |      |           |          |      |
|       |      |           |          |      |

## Setup

Run `startup.m`

Note [matlabPyrTools](https://github.com/gregfreeman/matlabPyrTools) is required to run VIF metric (`vif.m`).

## Usage

To reproduce our experiments, run `experiments.m`

