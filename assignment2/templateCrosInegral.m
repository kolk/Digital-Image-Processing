function templateCrosIntegral()
   
   clc;
   clear all;
   close all;
   
   imgOrg = imread('vegan.jpg');
   imgOrg = double(imresize(imgOrg, 0.5));
   
   testMat = [5 2 5 2; 3 6 3 6; 5 2 5 2; 3 6 3 6];
   integralSum = integralImage(imgOrg);%double(integralImage(imgOrg));%
  
  integralSquare = integralSquareImg(imgOrg);%integralImage(double(imgOrg).^2);%
   %integralSquare = integralSquareImage(imgOrg);
 
   template = double(imresize(imread('soy-dessert.jpg'), 0.5));
   windowSize = size(template);
   windowArea = size(template,1) * size(template,2);
   mnTemplate = mean(template(:));
   stdTemplate = std(template(:));
   tempDiff = template(:) - mnTemplate;
    %tempNorm = sum(tempDiff.^2);

   img = imgOrg;
   img = padarray(imgOrg, floor(windowSize/2), 'replicate');
    
   loc = [];
   resMax = 0;
   result = zeros(size(imgOrg));
   size(imgOrg,1)- windowSize(1)
   size(imgOrg,2)- windowSize(2)
   for i = 1:size(imgOrg,1)- windowSize(1) %340
      for j = 1:size(imgOrg,2)- windowSize(2) %512
          
           I = double(img(i:i + windowSize(1) -1 , j: j + windowSize(2) - 1));
           mnI = mean(I(:));
           stdI = std(I(:));
           
           %define the patch of image
           
           lastX = i + windowSize(1)-1;
           lastY = j + windowSize(2)-1;
          
           summation = integralSum(lastX, lastY) - integralSum(i, lastY) - integralSum(lastX, j) + integralSum(i , j);
           %mnI = summation /windowArea; 
           squareSum = integralSquare(lastX, lastY)  - integralSquare(i, lastY) - integralSquare(lastX , j ) + integralSquare(i, j);
           avgI = I(:) - squareSum/windowArea;  
           numerator = (avgI'*tempDiff);
           
           denominator = sqrt(squareSum);
           %denominator = sqrt((squareSum - (summation^2/windowArea))*stdTemplate);
           %temp = %((squareSum - summation^2/windowArea)'*(tempDiff));
           %disp(['equal ' num2str(sqrt((squareSum - (summation^2/windowArea))) == stdI)]);
                 
           
           
           result(i,j) = numerator /denominator;%(integralSum(floor(lastX/4), floor(lastY/4)) - integralSum(i - 1 + 1, floor(lastY)) + integralSum(floor(lastX/4), j - 1 + 1) + integralSum(i - 1 + 1, j - 1 + 1))/ sqrt(squareSum*tempNorm) ;      
          
           if result(i,j) >= resMax
              resMax = result(i,j);
              loc = [i j];
              maxVal = result(i,j);
           end
           %{
              if j ==   402- floor(windowSize(2)/2)%308 %
               if i == 372 - floor(windowSize(1)/2)%337%
                   disp('************')
                   result(i,j)
                   res
                   figure;
                   drawnow;
                   hold on;
   
   
                   imshow(mat2gray(imgOrg));
                   rectangle('Position', [j,i, windowSize(2), windowSize(1)], 'EdgeColor', 'r', 'LineWidth', 2);
                   figure;
                    imshow(uint8(result));
   
                     rectangle('Position', [j,i, windowSize(2), windowSize(1)], 'EdgeColor', 'r', 'LineWidth', 2);
               end
           end
             %}       
          
      end
   end
  
   %{
   boundingBoxX = ;
   boundingBoxY = ;
   length = windowSize;
   %}

   loc
   result = floor(result);
   result(find(result < 0)) = 0;
   maxVal = max((result(:)))
   idx = find(result == maxVal)
   
   [x,y] = ind2sub([size(imgOrg,1) size(imgOrg,2)], idx)
     figure;
   
   
   drawnow;
   hold on;
   
   
   imshow(mat2gray(imgOrg));
   rectangle('Position', [y(1), x(1), windowSize(2), windowSize(1)], 'EdgeColor', 'r', 'LineWidth', 2);
   figure;
   imshow(uint8(result));
   
   rectangle('Position', [y(1), x(1), windowSize(2), windowSize(1)], 'EdgeColor', 'r', 'LineWidth', 2);
 
end


function integral = integralImg(img)
   integral = zeros(size(img));
   integral = [zeros(size(integral,1),1) integral];
   integral = [zeros(1,size(integral,2)); integral];
   for j = 1: size(img,2)
       for i = 1: size(img,1)
          integral(i+1,j+1) = img(i,j) + integral(i, j+1) + integral(i+1, j) - integral(i,j);
       end
   end
   %integral = integral(2:size(integral,1), 2:size(integral,2));
end

function integral = integralSquareImg(img)
   integral = zeros(size(img));
   integral = [zeros(size(integral,1),1) integral];
   integral = [zeros(1,size(integral,2)); integral];
   for j = 1: size(img,2)
       for i = 1: size(img,1)
          integral(i+1,j+1) = img(i,j)^2 + integral(i, j+1) + integral(i+1, j) - integral(i,j);
       end
   end
   %integral = integral(2:size(integral,1), 2:size(integral,2));
end
  %}