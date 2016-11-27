function templateCrossCorrelation()
   clear all;
   clc;
   close all;
   
   %% input reading
   %read input image
   imgOrg = imresize(imread('vegan-modified.jpg'),0.5);
   template = double(imresize(imread('soy-dessert.jpg'), 0.5));
   windowSize = size(template);
   img = imgOrg;
   img = padarray(imgOrg, floor(windowSize/2), 'replicate');
   dim = size(imgOrg);
      
   %% normalized cross correlation
   loc = [];
   resMax = 0;
   result = ones(size(imgOrg))*255;
   mnTemplate = mean(template(:));
   stdTemplate = std(template(:));
   tempDiff = (template(:) - mnTemplate)/stdTemplate;

   
   for i = 1:dim(1)
      for j = 1:dim(2)
          
          %define the patch of image
           I = double(img(i:i + windowSize(1) -1 , j: j + windowSize(2) - 1));
           
           %distance metric
           mnI = mean(I(:));
           stdI = std(I(:));
           
           %dot product of the zero mean image patch and the template
           temp = ((I(:) - mnI)'*tempDiff);
           
           %cross correlation value
           result(i,j) = temp/ (stdI);
           
           
           %find the maximum cross correlation value
           if result(i,j) > resMax
               resMax = result(i,j);
               loc = [i j];
          end
           
      end
   end
   

   drawnow;
   hold on;

   imshow(imgOrg);
   rectangle('Position', [loc(2) - windowSize(2)/2, loc(1) - windowSize(1)/2, windowSize(2), windowSize(1)], 'EdgeColor', 'r', 'LineWidth', 2);
   title(['Image with Bounding Box around the patch with the min sum of absolute difference loc '  num2str(loc(1)) ', ' num2str(loc(2))]);
   figure;
   imshow(mat2gray(result));
   rectangle('Position', [loc(2) - windowSize(2)/2, loc(1) - windowSize(1)/2, windowSize(2), windowSize(1)], 'EdgeColor', 'r', 'LineWidth', 2);
   title(['cross correlation result with Bounding Box around the patch with the min sum of absolute difference loc '  num2str(loc(1)) ', ' num2str(loc(2))]);
   hold off;
end


