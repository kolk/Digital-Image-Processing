close all;
clc;
im=imread('Amazon-Rainforest-Waterfalls.jpg');
imNoise = imnoise(im, 'gaussian',0, 0.005);
figure;
imshow(im);
title('Original Image');
figure;
imshow(imNoise);
title('Noisy Image');

[LL, LH, HL, HH]=dwt2(imNoise,'haar');

figure;
subplot(221);
imshow(uint8(LL));
title('LL band of Noisy image');
subplot(222);
imshow(uint8(LH));
title('LH band of Noisy image');
subplot(223);
imshow(uint8(HL));
title('HL band of Noisy image');
subplot(224);
imshow(uint8(HH));
title('HH band of Noisy image');

% apply hard threshold to 1st level detail wavelet coefficients
LH(LH < max(LH(:))*0.07) = 0;
HL(HL < max(HL(:))*0.07) = 0;
HH(HH < max(HH(:))*0.07) = 0;

% apply hard threshold to 2nd level detail wavetel coefficients
[LL2, LH2, HL2, HH2]=dwt2(HH,'haar');
LH2(LH2 < max(LH2(:))*0.01) = 0;
HL2(HL2 < max(HL2(:))*0.01) = 0;
HH2(HH2 < max(HH2(:))*0.05) = 0;

% apply hard threshold to 3rd level detail wavelet coefficients
[LL3, LH3, HL3, HH3]=dwt2(HH2,'haar');
LH3(LH3 < max(LH3(:))*0.01) = 0;
HL3(HL3 < max(HL3(:))*0.01) = 0;
HH3(HH3 < max(HH3(:))*0.01) = 0;


HH2 = idwt2(LL3, LH3, HL3, HH3,'haar');
%HH2temp = idwt2(LL3, LH3, HL3, HH3,'haar');
%HH2 = imresize(HH2temp, [size(HH2, 1) size(HH2, 2)]);
HH = idwt2(LL2, LH2, HL2, HH2,'haar');

X = idwt2(LL,LH, HL, HH, 'haar'); 
figure;
imshow(mat2gray(X));
title('Denoised Image');