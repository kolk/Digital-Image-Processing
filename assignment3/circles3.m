clear;
close all;
im = imread('circles.jpg');
im = rgb2gray(im);
se = strel('disk',3);
afterOpening = imopen(im,se);
figure;
imshow(im);
im = afterOpening;


figure;
imshow(afterOpening);

imBW = im2bw(im, 0.15);

L = bwlabel(imBW);
s = regionprops(L, 'Area');
s = [s.Area];
s = sort(s);
sz = unique(s);
size(sz)
%idx = find((100 <= area_values) & (area_values <= 1000))