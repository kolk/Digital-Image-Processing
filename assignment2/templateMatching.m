function templateMatching()

   
   %load the image
   imgOrg = imresize(imread('vegan.jpg'),0.5);
   template = double(imresize(imread('soy-dessert.jpg'), 0.5));
   windowSize = size(template);
   img = imgOrg;
   img = padarray(imgOrg, floor(windowSize/2), 'replicate');
   dim = size(imgOrg);
      
   loc = [];
   %intialize the min value to a large value 
   resMin = 10^9;
   
   %initialize the sum of difference matrix
   result = ones(size(imgOrg))*255;
   
   for i = 1:dim(1)
      for j = 1:dim(2)
          
           %find the midpoint of the window0
           mid = double(img(i+ floor(windowSize(1)/2),j+floor(windowSize(2)/2)));
           
           %define the patch of image
           I = double(img(i:i + windowSize(1) -1 , j: j + windowSize(2) - 1));
           
           %subtract the image patch and template
           temp = (I - template);
          
           %sum of absoulte difference
           result(i,j) = sum(abs(temp(:)));
           
           %find the min intensity value in the sum of absolute difference
           if result(i,j) < resMin
               resMin = result(i,j);
               loc = [i j];
   
           end
      end
   end
   
   disp(['The location of min intensity is at location ' num2str(loc(1)) ', ' num2str(loc(2))]);
   figure;
   drawnow;
   hold on;
   figure;
   imshow(imgOrg);
   rectangle('Position', [loc(2) - windowSize(2)/2, loc(1) - windowSize(1)/2, windowSize(2), windowSize(1)], 'EdgeColor', 'r', 'LineWidth', 2);
   title(['Image with Bounding Box around the patch with the min sum of absolute difference loc '  num2str(loc(1)) ', ' num2str(loc(2))]);
   
   figure;
   imshow(mat2gray(result));
   rectangle('Position', [loc(2) - windowSize(2)/2, loc(1) - windowSize(1)/2, windowSize(2), windowSize(1)], 'EdgeColor', 'r', 'LineWidth', 2);
   title(['Sum of absolute difference Image with bounding box at ' num2str(loc(1)) ', ' num2str(loc(2))]);
end