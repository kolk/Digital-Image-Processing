function bilateralFilt()
   img = imread('face.png');

   %img = imread('boy_smiling.jpg');
   
   
   if ~isfloat(img)
      I = im2double(img);
   else
      I = img;
   end
   
   %output images initialization
   out = zeros(size(I));
   out2 = zeros(size(I));
   
   %apply filter for color or grayscale
   if size(size(img)) < 3
      out = bilateralGray(5, 3, 0.1, I);
      [out1,out2] = inverseBilateralGray(5, 1, 0.17, I);
       figure;
       imshow(out);
       figure;
       imshow([out1,out2]);
   else
      %apply various filter sizes
      outMat = [];
      for n = 5:5:15
         out = bilateralColor(n ,3, 0.15, I);
         outMat = [outMat out];
      end
       figure;
       imshow(outMat);
   end
  
end


function filter = gaussian2d(n, sig)
   [x,y] = meshgrid(ceil(-n/2):floor(n/2), ceil(-n/2):floor(n/2));
   filter = exp(-(x.^2 + y.^2)/(2*sig^2));
end

function out = bilateralGray(n, sig1, sig2, img)
   %create a gaussian spatial filter
   gaussFilt = gaussian2d(n, sig1);
   
   s = size(img);
   
   %add padding to image for cross-correlation
   img = [zeros(size(img,1),floor(n/2)) img zeros(size(img,1),floor(n/2))]
   img = [zeros(floor(n/2), size(img,2)); img; zeros(floor(n/2), size(img,2))]
   
   %output image
   out = zeros(s);
   
   %*****apply filter to 5x5 window size across image**************%
   for i = 1:s(1)
       for j = 1:s(2)
           
           %find the midpoint of the window
           mid = img(i+ floor(n/2),j+floor(n/2));
           
           %define the patch of image
           I = img(i:i + n -1 , j: j + n - 1);
           
           %calculate the intensity filter as a gaussian function
           intensityFilt = exp(-(I - mid).^2/(2*sig2^2));
           
           %calculate the final filter as a correlation between intensity
           %filter and gaussian spatial filter
           filter = intensityFilt .* gaussFilt;
                     
           %apply filter on patch
           
           out(i,j) = sum(filter(:).* I(:))/sum(filter(:));
           
       end
   end
end

function out = bilateralColor(n, sig1, sig2, img)
    gaussFilt = gaussian2d(n, sig1);
    s = size(img);
    img = [zeros(size(img,1),floor(n/2),3) img(:,:,:) zeros(size(img,1),floor(n/2),3)];
    img = [zeros(floor(n/2), size(img,2),3); img(:,:,:); zeros(floor(n/2), size(img,2), 3)];
     
    %output image
    out = zeros(s);
   
    %*****apply filter to 5x5 window size across image**************%
    for i = 1:s(1)
        for j = 1:s(2)
           
           %find the midpoint of the window across color channels
           midr = img(i+ floor(n/2),j+floor(n/2),1);
           midg = img(i+ floor(n/2),j+floor(n/2),2);
           midb = img(i+ floor(n/2),j+floor(n/2),3);
           
           %define the patch of image
           I = img(i:i + n -1 , j: j + n - 1,:);
           
           %find the intensity values differences of window across color channels
           dr = I(:,:,1) - midr;
           dg = I(:,:,2) - midg;
           db = I(:,:,3) - midb;
           
           %calculate the intensity filter as a gaussian function
           intensityFilt = exp(-(dr .^2 + dg .^2 + db .^2)/(2*sig2^2));
           
           %calculate the final filter as a correlation between intensity
           %filter and gaussian spatial filter
           gaussFilt = gaussFilt(1:size(intensityFilt,1), 1:size(intensityFilt,2));
           filter = intensityFilt .* gaussFilt;
                     
           %apply filter on patch
           scale = sum(filter(:));
           out(i,j,1) = sum(sum(filter.* I(:,:,1)))/scale;
           out(i,j,2) = sum(sum(filter.* I(:,:,2)))/scale;
           out(i,j,3) = sum(sum(filter.* I(:,:,3)))/scale;
           
           %concatenate the channels to form the color image
           
       end
   end
end

function [out1,out2] = inverseBilateralGray(n, sig1, sig2, img)
   %create a gaussian spatial filter
   gaussFilt = gaussian2d(n, sig1);
   
   s = size(img);
   
   %add padding to image for cross-correlation
   img = [zeros(size(img,1),floor(n/2)) img zeros(size(img,1),floor(n/2))];
   img = [zeros(floor(n/2), size(img,2)); img; zeros(floor(n/2), size(img,2))];
   
   %output image
   out1 = zeros(s);
   out2 = zeros(s);
   
   %*****apply filter to 5x5 window size across image**************%
   for i = 1:s(1)
       for j = 1:s(2)
           
           %find the midpoint of the window
           mid = img(i+ floor(n/2),j+floor(n/2));
           
           %define the path of image
           I = img(i:i + n -1 , j: j + n - 1);
           
           %calculate the intensity filter as a gaussian function
           intensityFilt1 =  exp(-(ones(size(I)) -(I  - mid)).^2/(2*sig2^2));
           intensityFilt2 =  exp((ones(size(I)) -(I  - mid)).^2/(2*sig2^2));
                      
           %calculate the final filter as a correlation between intensity
           %filter and gaussian spatial filter
           filter1 = intensityFilt1 .* gaussFilt;
           filter2 = intensityFilt2 .* gaussFilt;
                     
           %apply filter on patch
           out1(i,j) = sum(filter1(:).* I(:))/sum(filter1(:));
           out2(i,j) = sum(filter2(:).* I(:))/sum(filter2(:));
       end
       
   end
end