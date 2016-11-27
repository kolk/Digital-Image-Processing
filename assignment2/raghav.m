close all;
clear all;
clc;

img = rgb2gray(imread('rupee-symbol.jpg'));

[r,c] = size(img);

% Fourier Transform of image
img = double(img);
ft = fft2(img);
ft = fftshift(ft);

% Magnitude and Phase Spectrum
ft_r = abs(ft);
ft_a = angle(ft);

% plot of image , magnitude and phase
subplot(132),imshow(log(1+ft_r),[]);
title('magnitude spectrum ');
subplot(131),imshow(img);
title('original signal');
subplot(133),imshow(ft_a);
title('phase spectrum');

%% *Scaling the function: x[m,n] ? ax[m,n], here we take a = 2;*

sfimg = 2*img;

sfft = fft2(sfimg);
sfft = fftshift(sfft);

sfft_r = abs(sfft);
sfft_a = angle(sfft);

% plot of image , magnitude and phase
figure;
subplot(131),imshow(sfimg);
title('Scaling thw function');
subplot(132);imshow(log(1+sfft_r),[]);
title('magnitude spectrum');
subplot(133),imshow(sfft_a);
title('phase spectrum');

% difference in experiment image and original image
figure;
subplot(121),imshow(uint8(log(1+(sfft_r-ft_r))),[]);
title('difference in magnitude spectrum');
subplot(122),imshow(sfft_a-ft_a);
title('difference in phase spectrum');


%% *Scaling the argument: [m,n] ? [am,an], here we take a = 2;*

saimg = zeros(2*r,2*c);

for i = 1:r
    for j = 1:c
        saimg(2*i,2*j) = img(i,j);
    end
end

saft = fft2(saimg);
saft = fftshift(saft);

saft_r = abs(saft);
saft_a = angle(saft);

% plot of image , magnitude and phase
figure;
subplot(131),imshow(saimg);
title('scaling the argument');
subplot(132);imshow(log(1+saft_r),[]);
title('magnitude spectrum');
subplot(133),imshow(saft_a);
title('phase spectrum');

%% *Shifting the argument: [m,n] ? [m+m0,n+n0] , here m0 = 80, n0 = 80*

shimg = zeros(r,c);

for i = 81:r
    for j = 81:c
        shimg(i,j) = img(i-80,j-80);
    end
end

shft = fft2(shimg);
shft = fftshift(shft);

shft_r = abs(shft);
shft_a = angle(shft);

% plot of image , magnitude and phase
figure;
subplot(131),imshow(shimg);
title('Shifting the argument');
subplot(132);imshow(log(1+shft_r),[]);
title('magnitude spectrum');
subplot(133),imshow(shft_a);
title('phase spectrum');

% difference in experiment image and original image
figure;
subplot(121),imshow(uint8(log(1+(shft_r-ft_r))),[]);
title('difference in magnitude spectrum');
subplot(122),imshow(shft_a-ft_a);
title('difference in phase spectrum');

%% *Reflection about a vertical line (n=N/2: N is the width of the image):*
% *x[m,n] ? x[m,N-n]*

rvimg = zeros(r,c);

for i = 1:r
    for j = 1:c
        rvimg(i,j) = img(i,c-j+1);
    end
end

rvft = fft2(rvimg);
rvft = fftshift(rvft);

rvft_r = abs(rvft);
rvft_a = angle(rvft);

% plot of image , magnitude and phase
figure;
subplot(131),imshow(rvimg);
title('Shifting the argument');
subplot(132);imshow(log(1+rvft_r),[]);
title('magnitude spectrum');
subplot(133),imshow(rvft_a);
title('phase spectrum');

% difference in experiment image and original image
figure;
subplot(121),imshow(uint8(log(1+(rvft_r-ft_r))),[]);
title('difference in magnitude spectrum');
subplot(122),imshow(rvft_a-ft_a);
title('difference in phase spectrum');

%{
%% *High boost filtering of x with A = 1;*

d=100;
hp = zeros(r,c);
for m=1:r
    for n=1:c
        D = sqrt((m-(r/2))^2 + (n-(c/2))^2);
        if d <= D
            hp(m,n)= 1;
        else
            hp(m,n)=0;
        end
    end
end

hpft = ft.*hp;

hpft_r = abs(hpft);
hpft_a = angle(hpft);

hbft = ft + hpft;
hbft_r = abs(hbft);
hbft_a = angle(hbft);

hbft = ifftshift(hbft);
hbimg = ifft2(hbft);

% plot of image , magnitude and phase
figure;
subplot(132),imshow(uint8(log(1+hbft_r)),[]);
title('magnitude spectrum');
subplot(133),imshow(hbft_a);
title('phase spectrum')
subplot(131);imshow(uint8(hbimg),[]);
title('high boost image');

% difference in experiment image and original image
figure;
subplot(121),imshow(uint8(log(1+(hbft_r-ft_r))),[]);
title('difference in magnitude spectrum');
subplot(122),imshow(hbft_a-ft_a,[]);
title('difference in phase spectrum');
%}