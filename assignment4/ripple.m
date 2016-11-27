close all;
im=imread('Amazon-Rainforest-Waterfalls.jpg');
figure;
imshow(im);
title('Original Image');
[m,n,c] = size(im);

%parameters of ripple transform
ax = 10;
ay = 15;
wx = 120;
wy = 150;

out = zeros(m,n,c);
%perform ripple transform
for i = 1:m
    for j = 1:n
        oldX = round(i + ax*sin(j*2*pi/wx));
        oldY = round(j + ay*sin(i*2*pi/wy));
        
        %check boundary conditions
        oldX = mod(oldX, m - 1) + 1;
        oldY = mod(oldY, n - 1) + 1;
        out(i,j,:) = im(oldX, oldY,:);
        
    end
end

figure;
imshow(mat2gray(out));
title('Ripple transformation');