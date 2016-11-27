clear all;
clc;

%read image
I = imread('chip.jpg');

%get histogram
H = get_hist(I);

%calculate CDF
C = cumsum(H);

%display histeq image
J = intlut(uint8(I),uint8(C*255));
figure,imshow(uint8(J),[]), xlabel('HistEQ Image');

% 1. ramp function
minval = 1; maxval = 256;
r = linspace(minval,maxval,256);

%normalise 
r = double(r)/sum(r);

%get the lut map
lut_map = get_lut_map(H,r);

%generate the mapped image
J = intlut(uint8(I),uint8(lut_map));
figure,imshow(uint8(J),[]), xlabel('Ramp Function');