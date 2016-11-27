function unsharpMasking()
   img = imread('bell.jpg');
   
   %vary the multiplicative constant for the highpass filter
   for k = 2:4:12
      %output matrix of images
      resColorMat = [];
      
      %vary the filter size
      for m = 3:2:9
         %generate the mean filter
         meanFilt = ones(m,m)/(m*m)
         
         %apply the filter to the image
         smoothedImgColor = imfilter(img, meanFilt);
    
         %generate the highpass filter      
         diffColor = abs(img - smoothedImgColor);
         
         %apply the scaled highpass filter on the image
         resColor = img + diffColor .* k;
         resColorMat = [resColorMat resColor];
     end
      figure;
      imshow(resColorMat);
   end
end