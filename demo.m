I = imread('yellowlily.jpg');
J = BIMEF(I); 
subplot 121; imshow(I); title('Original Image');
subplot 122; imshow(J); title('Enhanced Result');