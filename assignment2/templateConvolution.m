clear all;
clc;
close all;
tic
   imgOrg = imresize(imread('vegan.jpg'),0.5);
   template = imresize(imread('soy-dessert.jpg'), 0.5);
   imgOrg = imgOrg - mean(imgOrg(:));
   template = template - mean(template(:));
   windowSize = size(template);
 
   fftImg = fftshift(fft2(double(imgOrg)));
   
   %template = padarray(template, ceil((size(fftImg)-size(template))/2));
   %template = imresize(template, size(fftImg));
   fftTemp = fftshift(fft2(rot90(template,2), size(imgOrg,1), size(imgOrg,2)));
   
   C = ifft2(fftImg .* conj(fftTemp));

   figure;
   imshow(log(1+fftTemp),[]);
   
   figure;
   imshow(log(1+fftImg),[]);
   
   imshow(abs(log(C + 1)),[]);
   maxVal = max(C(:))
   loc = find(C == maxVal)
   [x,y] = ind2sub([size(imgOrg,1) size(imgOrg,2)], loc)
   x = x - ceil((size(fftImg)-size(template))/2)
   y = y - ceil((size(fftImg)-size(template))/2)
   drawnow;
   hold on;
   figure;
   imshow(imgOrg);  
   rectangle('Position', [y(1) , x(1) , windowSize(2), windowSize(1)], 'EdgeColor', 'r', 'LineWidth', 2);
   title(['Image with Bounding Box around the patch with the min sum of absolute difference loc '  num2str(x) ', ' num2str(y)]);
   tac
 