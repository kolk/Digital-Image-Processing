close all;
[gifImage cmap] = imread('octone.gif');
rgbImage = ind2rgb(gifImage, cmap);
imshow(rgbImage);
gray = rgb2gray(rgbImage);
figure;
imshow(gray);
gray
%gray(gray< 10) = 0;

for i = 1:size(gray,1)
    for j = 1:size(gray,2)
        if gray(i,j) >0.90 && gray(i,j) < 0.96
            'found'
            gray(i,j) = 1;
        else
            gray(i,j) = 0;
        end
    end
end


ft = fft2(gifImage);
mag = abs(ft);
phse = angle(ft);
figure;
imshow(log(1+mag),[]);

%gray(gray == 255) = 0;
%size(find(gray < 255 && gray >240))
%gray(gray>235) = 255;
figure;
imshow(gray)
%hsvIm = rgb2hsv(rgbImage);
%figure;
%imshow(hsvIm);