function matchHistogram()
   img = imread('office.jpg');
   img = rgb2gray(img);
   cdfImage = findCdf(img);
   
   
   %generate step function
   step = zeros([256 256], 'uint8');
   for i = 128:256
      step(:,i) = i-1;
   end
   step = uint8(step);
   
   %histogram of step
   figure;
   imhist(step);
   
    %cumulative distribution function of step
   cdfStep = findCdf(step);
   
   %match the image to step histogram
   mapping(cdfImage, cdfStep, img);
   
   
   %generate ramp function
   ramp = zeros([1 32768],'uint8');
   index = 1;
   for i = 1:256
      ramp(1,index:index+i) = i-1;
      index = index + i;
   end
   ramp = reshape(ramp(1:257*128),257,128); 
   
   %histogram of ramp
   figure;
   imhist(ramp);
   ramp = uint8(ramp);
   
   %cumulative distribution function of ramp
   cdfRamp = findCdf(ramp);
   
   %match the image to ramp histogram
   mapping(cdfImage, cdfRamp, img);
end

function mapping(cdfImg1, cdfImg2, img)
    mapping = zeros(256, 1);
   for i = 1: 256
       
       [~,ind] = min(abs(cdfImg1(i) - cdfImg2));
       mapping(i) = ind - 1;    %intensity = index - 1
      
   end
   
  
   out = zeros(size(img));
   for i = 1:size(img,1)
       for j = 1:size(img,2)
           out(i,j) = mapping(img(i,j) + 1);
       end
   end
   out = mat2gray(out);
   figure;
   imshow(out);
   figure;
   imhist(out);
end

%cumulative distribution function for image intensities
function cdf = findCdf(img)
   dim = size(img);
   bins = 255;
   
   %calculate the intensity frequencies
   intensityFreq = zeros(256,1);
   for i = 1:dim(1)
       for j = 1:dim(2)
           
         intensityFreq(img(i,j) + 1) = intensityFreq(img(i,j) + 1) + 1; 
       end
   end
  
   %probability of each intensity value
   intensityFreq = intensityFreq ./ (dim(1)*dim(2));
   
   %calculate the cumulative distribution function of intensities
   cdf = zeros(256, 1);
   cdf(1) = intensityFreq(1);
   for i = 2:256
       cdf(i) = cdf(i - 1) + intensityFreq(i);
   end
  
   %scale the frequency to the number of bins
   cdf = round( cdf .* bins);
end