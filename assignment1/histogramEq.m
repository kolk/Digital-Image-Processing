function histogramEq()
  img = rgb2gray(imread('office.jpg'));
  hist = zeros(256,1);
  dim = size(img);
  bins = 255;
  
  %calculate the intensity frequencies
  intensityFreq = zeros(256,1);
  for i = 1:dim(1)
      for j = 1:dim(2)
        intensityFreq(img(i,j) + 1) = intensityFreq(img(i,j) + 1) + 1; 
      end
  end
  
  intensityFreq = intensityFreq ./ (dim(1)*dim(2));
  %calculate the cumulative distribution function of intensities
  cdf = zeros(256, 1);
  cdf(1) = intensityFreq(1);
  for i = 2:256
      cdf(i) = cdf(i - 1) + intensityFreq(i);
  end
  
  %scale the frequency
  cdf = round( cdf .* bins)
  
  %output image as a function of cdf
  output = mat2gray(cdf(img(:,:) + 1));
  
   %subplot(320), 
  figure;
  imshow(img);
  figure;
  imhist(img);
  figure;
  imshow(output);
  figure;
  imhist(output); 
end