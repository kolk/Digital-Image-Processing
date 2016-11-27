clc;
clear all;
close all;
img = double(rgb2gray(imread('rupee-symbol.jpg')));

imgfft = fftshift(fft2(img));
magnitudefft1 = abs(imgfft);
phasefft1 = angle(imgfft);

figure;
subplot(131), imshow(imgfft);
title('Image fft');
subplot(132),imshow(log(magnitudefft1 + 1),[]);
title('Image magnitude spectrum ');
subplot(133),imshow(phasefft1);
title('Image phase spectrum');

%% Question 1 scaling the image intensities

a = 2;
scaled = img*a;
scaledfft = fftshift(fft2(scaled));
magnitudefft2 = abs(scaledfft);
phasefft2 = angle(scaledfft);

figure;
subplot(131), imshow(scaledfft);
title('Scaled fft');
subplot(132),imshow(log(1+magnitudefft2),[]);
title('Scaled magnitude spectrum ');
subplot(133),imshow(phasefft2);
title('Scaled phase spectrum');

figure;
subplot(131),imshow(abs(phasefft2 - phasefft1)); %phase remains same
title('Phase spectrum difference');
subplot(133),imshow(abs(log(1+magnitudefft2) - log(a*magnitudefft1 + 1)),[]); %magnit
title('Magnitude spectrum difference ');
subplot(132), imshow(mat2gray(abs(a*imgfft - scaledfft)));
title('fft difference');

%% Question 2 scaling of parameters

a = 2;
imgArgScaled = zeros(a*size(img));

for i = 1:size(img,1)
    for j = 1:size(img,2)
        imgArgScaled(a*i,a*j) = img(i,j);
    end
end

scaledfft = fftshift(fft2(imgArgScaled));
magnitudefft2 = abs(scaledfft);
phasefft2 = angle(scaledfft);

fftSample = zeros(size(scaledfft)/a);
for i = 1:size(fftSample,1)
    for j = 1:size(fftSample,2)
        fftSample(ceil(i/a),ceil(j/a)) = scaledfft(i,j);
    end
end
fftSample = fftSample*a;

figure;
subplot(321), imshow(imgArgScaled,[]);
title('parameter scaled image');
subplot(322), imshow(scaledfft);
title('Scaled fft');
subplot(323),imshow(log(1+magnitudefft2),[]);
title('Scaled magnitude spectrum ');
subplot(324),imshow(phasefft2);
title('Scaled phase spectrum');
subplot(325), imshow(mat2gray(abs(fftSample - imgfft)));
title('fft difference');


%% Question 3 Shifting of Image

m0 = floor(size(img,1)/6);
n0 = floor(size(img,2)/6);
%phaseShift = zeros(size(img));

shiftedImg = img(:, mod((1:size(img,2))+size(img,2) + n0, size(img,2)) + 1);
shiftedImg = shiftedImg(mod((1:size(img,1))+size(img,1)+m0,size(img,1))+1,:);

shiftedfft = fftshift(fft2(shiftedImg));
magnitudefft2 = abs(shiftedfft);
phasefft2 = angle(shiftedfft);

figure;
subplot(221), imshow(shiftedImg,[]);
title('shifted image');
subplot(222), imshow(shiftedfft);
title('Shifted fft');
subplot(223),imshow(log(1+magnitudefft2),[]);
title('Shifted magnitude spectrum ');
subplot(224),imshow(phasefft2);
title('Shifted phase spectrum');

figure;
subplot(131),imshow(abs(phasefft2 - phasefft1)); %phase remains same
title('Phase spectrum difference');
subplot(133),imshow(abs(log(1+(magnitudefft2 - magnitudefft1))),[]); %magnit
title('Magnitude spectrum difference ');
subplot(132), imshow(mat2gray(abs((imgfft  - shiftedfft))));
title('fft difference');


%% Question 4 Flipping the image



rotatedImg = img(:,size(img,2):-1:1);
shiftedfft = fftshift(fft2(rotatedImg));
magnitudefft2 = abs(shiftedfft);
phasefft2 = angle(shiftedfft);


% plot of image , magnitude and phase
figure(9);
subplot(221), imshow(rotatedImg,[]);
title('shifted image');
subplot(222), imshow(shiftedfft);
title('Shifted fft');
subplot(223),imshow(log(1+magnitudefft2),[]);
title('Shifted magnitude spectrum ');
subplot(224),imshow(phasefft2);
title('Shifted phase spectrum');

figure;
subplot(121),imshow(abs(phasefft2 - phasefft1)); %phase remains same
title('Phase spectrum difference');
subplot(122),imshow(abs(log(1+(magnitudefft2 - magnitudefft1))),[]); %magnit
title('Magnitude spectrum difference ');