clear all
[gifImage cmap] = imread('map.gif');
gray = ind2gray(gifImage, cmap);
I=gray;
I=im2double(I);
m=size(I,1);n=size(I,2);
[x,y] = meshgrid(1:n,1:m);                    % grid inherited from the original image

theta=pi/4;                                   % angle of rotation
x0=fix(n/2);
y0=fix(m/2);                                  % center of rotation
p=(x-x0).*cos(theta)+(y-y0).*sin(theta)+x0;   % transformed coordinates (new pixel locations)
q=-(x-x0).*sin(theta)+(y-y0).*cos(theta)+y0;

Ifinal=interp2(x,y,I,p,q,'bicubic');          % intensity values interpolation at new locations

figure
subplot(1,2,1),imagesc(I),axis image
title('Original','FontSize',18)
subplot(1,2,2),imagesc(Ifinal),axis image
title('Transformed','FontSize',18)
imshow(gray)


[my,mx] = meshgrid(1:n,1:m);
x0=fix(n/2);
y0=fix(m/2);
newY = asin(my-x0)*n/(pi*2)+ n/2;
newX = mx;
Ifinal=interp2(my,mx,I,newY,newX,'bicubic');          % intensity values interpolation at new locations
figure;
imshow(Ifinal)
