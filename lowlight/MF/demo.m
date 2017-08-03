clc;
clear all;


input = imread('.\test images\9.jpg'); 

output = multi_fusion(input);

figure,imshow(input),title('original image');
figure,imshow(output),title('enhanced image');