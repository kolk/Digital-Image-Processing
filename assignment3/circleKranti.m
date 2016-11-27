clc
clear all
close all

%% Extracting Circles...
II = rgb2gray(imread('circles.jpg'));
[m n]=size(II);
I = imfilter(II,ones(3)/9);
se = ones(3);

Io = imtophat(I,se);
% bwI = im2bw(I);
% bwIo = im2bw(Io);
% figure, subplot(221),imshow(I);
% subplot(222),imshow(Io);
% subplot(223),imshow(bwI);
% subplot(224),imshow(bwIo);

th = (I-Io)>40;

figure,imshow(th,[])

[L,num] = bwlabel(th);
for i=1:num
    [a b]=find(L==i);
    t(i) = length(a);
end

radius = round(sqrt(t/pi));
GroupRadius = unique(radius)
NoofGroups = length(GroupRadius)

for i=1:NoofGroups
    a = find(radius==GroupRadius(i));
    LI = zeros(m,n);
    for j=1:length(a)
        LI = LI + (L==ones(m,n)*a(j));
    end
    figure,imshow(LI,[])
    hold off
end