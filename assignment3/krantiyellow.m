clc
clear all
close all

%%
II = imread('octone.jpg');
h = ones(4)/16;
I = imfilter(II,h);


R = im2bw(I(:,:,1));
G = im2bw(I(:,:,2));
B = im2bw(I(:,:,3));

I1 = R&G&(1-B);
temp(:,:,1)= I1;temp(:,:,2) = I1;temp(:,:,3) = I1;
I2 = uint8(double(II).*temp);
I3 = II - I2;

figure,
subplot(131),imshow(II);
subplot(132),imshow(I2);
subplot(133),imshow(I3);

% figure,
% subplot(221),imshow(II);
% subplot(222),imshow(I1);
% subplot(223),imshow(I2);
% subplot(224),imshow(I3);