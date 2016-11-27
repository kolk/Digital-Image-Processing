%% reading images
img1 = imread('test-images-for-q2/son3.gif');
img1 = im2double(img);
img2 = imread('test-images-for-q2/son3rot1.gif');
img2 = im2double(img2);
img3 = imread('test-images-for-q2/son3rot2.gif');
img3 = im2double(img3);
img4 = imread('test-images-for-q2/son3rot3.gif');
img4 = im2double(img4);

%% fft calculations
fft_1 = log(fftshift(fft2(img1))+1);
fft_2 = log(fftshift(fft2(img2))+1);
fft_3 = log(fftshift(fft2(img3))+1);
fft_4 = log(fftshift(fft2(img4))+1);

%% line fitting
[i1,j1] = find(fft_1 > 0.85*max(fft_1(:)))
[i2,j2] = find(fft_2 > 0.85*max(fft_2(:)));
[i3,j3] = find(fft_3 > 0.85*max(fft_3(:)));
[i4,j4] = find(fft_4 > 0.85*max(fft_4(:)));
%{
line1 = fit(i1,j1,'poly1');
line2 = fit(i2,j2,'poly1');
line3 = fit(i3,j3,'poly1');
line4 = fit(i4,j4,'poly1');

angle1 = atan(line1.p1)*180/pi;
angle2 = atan(line2.p1)*180/pi - angle1;
angle3 = atan(line3.p1)*180/pi - angle1;
angle4 = atan(line4.p1)*180/pi - angle1;
%}