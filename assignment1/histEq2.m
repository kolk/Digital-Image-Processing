function histEq()
   img = imread('office.jpg');
   gray = rgb2gray(img);
   class(gray)
   [p, freq] = prob(gray);
   tr = cmf(p);
   %print tr;
   bins = 255;
   s = round(tr .* bins);
   
   out = zeros(size(gray));
   colorOut = zeros(size(img));
   for i = 1:size(gray,1)
       for j = 1:size(gray,2)
           out(i,j) = s(gray(i,j) + 1);
           colorOut(i,j,1) = uint8(s(img(i,j,1) + 1));
           colorOut(i,j,2) = uint8(s(img(i,j,2) + 1));
           colorOut(i,j,3) = uint8(s(img(i,j,3) + 1));
       end
   end
   
   figure(1);
   out = mat2gray(out);
   imshow(out);
   
   figure(2);
   imhist(out);
   
   figure;
   imhist(histeq(gray));
   
   %imshow(mat2double(colorOut(:,:,1)));
   %imhist(gray);
   %imhist(out);
end
 
function histMatch(gray)
   [p, freq] = prob(gray);
   tr = cmf(p);
   %print tr;
   bins = 255;
   s1 = round(tr .* bins);
  
   r = ramp(255);
   pdf = hist(r, 255);
   [p2, freq2] = probList(r);
   tr2 = cfd(p2);
   s2 = round(tr2 .* bins);
   
   mapping = zeros(256,1);
   for i = 1: 255
       [~,ind] = min(abs(s1(i) - s2));
       mapping(i) = ind - 1;    
      
   end
   out = mapping(img + 1);
   figure;
   imshow(mat2gray(out));
   
end

function his = findHist(s,dim)
   his = zeros(255,1);
   l = zeros(255,1);
   for i = 1:255
       l(i) = []
   end
   for i=1:255
       
       his(i) = hist(i) + sum(freq(s(i)))/dim;
   end
   
end




%%find prob of image intensties
function [p, freq] = prob(img)
   %scale factor
   scale = size(img,1) * size(img,2);
   
   %frequency list
   freq = zeros(255,1);
 
   %calculate #pixels for each intensity value
   for i = 1:size(img,1)
       for j = 1:size(img,2)
           freq(img(i,j) + 1) = freq(img(i,j) + 1) + 1;
       end
   end
   
   %calculate probability
   p = freq ./ scale;
end

%%find cumulative probabilites of image intensity
function c = cmf(l)
   c = zeros(length(l),1);
   c(1) = l(1);
   
   %calculate the cumulative probs by adding
   for i = 2:length(l)
       c(i) = c(i - 1) + l(i);
   end
end