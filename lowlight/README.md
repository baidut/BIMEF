Lowlight enhancement algorithms, including

* LIME
* Dong
* MF
* MSRCR `MultiscaleRetinex.m`
* NPE
* SRIE

```
I = imread('yellowlily.jpg');  % a color image
J = lime(I);                   % or other method
subplot 121; imshow(I); title('Original Image');
subplot 122; imshow(J); title('Enhanced Result');
```

Please contact me if you want the source code of our method (BIMEF) .

Email: yingzhenqiang(at)gmail(dot)com