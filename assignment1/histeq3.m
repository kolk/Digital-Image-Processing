function histeq3()
   img = imread('office.jpg');
   img = rgb2gray(img);
   hist = calHist(img);
   figure;
   stem(hist);
   figure;
   imhist(mat2gray(img));
end

function h = calHist(img)
   img = img(:);
   h = zeros([256 1], 'uint8');
   for i = 0:255
       h(i + 1) = length(find(img == i));
   end
   
end

function cdf(hist)

end