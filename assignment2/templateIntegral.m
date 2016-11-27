
function templateIntegral()
%% input reading
tic

clc
clear all
close all

%read input image
img = double(imresize(imread('vegan-modified.jpg'),0.5));

windowSize = size(img);
template = imread('soy-dessert.jpg');
template = double(imresize(template,0.5));
windowSize = size(template);
windowArea = size(template,1) * size(template,2);

%form integral image of the image
integralSum = integralImage(img);

%form integral image of the square of the intensities of the image
integralSquare = integralImage(img.^2);


temDiff = template(:) - mean(template(:));
temStd = std(template(:));

%% normalized cross correlation
maxResult = 0;
result = ones(size(img))*255;
[Nx,Ny] = size(template);
for i = 1 : size(img,1) - Nx
	for j = 1 : size(img,2) - Ny
        
        %extreme end position of the patch
        lastX  = i + windowSize(1)-1;
        lastY = j + windowSize(2)-1;
        
		%patch of image
        I = img(i:lastX ,j:lastY);
        
        %sum of intensities of the patch
        areaI = (integralSum(lastX ,lastX ) + integralSum(i,j) - integralSum(lastX ,j) - integralSum(i,lastX));
        
        %average of intensities of the patch
		avgI = areaI ./ (windowArea);
        
        %conversion to zero mean patch
		meanZeroI = I - avgI;
        
        %numerator of the cross-corrleation
        numerator = meanZeroI(:)' * temDiff(:);
        
        %demoniator for normalization by standard deviation
	    denominator = sqrt((integralSquare(i+Nx-1,j+Ny-1) + integralSquare(i,j) -integralSquare(i+Nx-1,j) -integralSquare(i,j+Ny-1)) - (avgI^2))*temStd;
        
        %the cross-correlation result
    	result(i,j) = numerator / denominator;
               
		if maxResult < result(i,j)
			maxResult = result(i,j);
			x = i; y = j;
		end
	end
end

drawnow;
   hold on;
   imshow(mat2gray(img));
   rectangle('Position', [y , x , windowSize(2), windowSize(1)], 'EdgeColor', 'r', 'LineWidth', 2);
   title(['Image with Bounding Box around the patch with the min sum of absolute difference loc '  num2str(x) ', ' num2str(y)]);
toc
end

%% form the integral image
function integral = integralImg(img)
   integral = zeros(size(img));
   integral = [zeros(size(integral,1),1) integral];
   integral = [zeros(1,size(integral,2)); integral];
   for j = 1: size(img,2)
       for i = 1: size(img,1)
          integral(i+1,j+1) = img(i,j) + integral(i, j+1) + integral(i+1, j) - integral(i,j);
       end
   end
end


