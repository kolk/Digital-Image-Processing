function histMatch()
   img = imread('office.jpg');
   gray = rgb2gray(img);
   figure(1);
   imhist(gray);
   
   [p, freq] = prob(gray);
   tr = cfd(p);
   %print tr;
   bins = 256;
   s1 = round(tr .* bins);
   
   ramp = zeros([255*128 1],'uint8');
   ind = 1;
   for i = 1:256
       ramp(ind:ind+i) = i -1 ;
       ind = ind + i;
   end
   size(ramp)
   ramp = ramp(1:length(ramp)-2);
   ramp = reshape(ramp,255,129);
   ramp = mat2gray(ramp);
   imhist(ramp);
   %figure(4);
   %hist1 = imhist(ramp);
   %cumsum(hist1) / numel(im1)
   %{
   %step histogram
   step = zeros(256, 1);
   step(128:256) = 255;
    %step = step;
   
   step = mat2gray(step);
   figure(2);
   stem(step);
   
   tr2 = cfd(step ./ 256)
   s2 = round(tr2 .* bins);
   
   mapping = zeros(256,1);
   for i = 1: 256
       [~,ind] = min(abs(s1(i) - s2));
       mapping(i) = ind - 1;    
      
   end
   out = mapping(gray + 1);
   figure(3);
   imshow(mat2gray(out));
   %}
   %{
   %ramp histogram
   ramp = zeros([255*128 1],'uint8');
   ind = 1;
   for i = 1:256
       ramp(ind:ind+i) = i -1 ;
       ind = ind + i;
   end
   size(ramp)
   ramp = ramp(1:length(ramp)-2);
   ramp = reshape(ramp,255,129);
   ramp = mat2gray(ramp);
   figure(4);
   imhist(ramp);
   %}
   %{
  
   
   pdf = hist(step, 255);
   [p2, freq2] = probList(step);
   tr2 = cfd(p2);
   s2 = round(tr2 .* bins);
   
   mapping = zeros(256,1);
   for i = 1: 255
       [~,ind] = min(abs(s1(i) - s2));
       mapping(i) = ind - 1;    
      
   end
   out = mapping(img + 1);
   figure(3);
   imshow(mat2gray(out));
   %}
end


function [p, freq] = probList(l)
   p = zeros(length(l),1);
   freq = zeros(256,1);
   
   s = length(l);
   for i = 1:length(l)
      freq(l(i) + 1) = freq(l(i) + 1) + 1;
   end
   p = freq ./ s;
end

%%find prob of image intensties
function [p, freq] = prob(img)
   %scale factor
   scale = size(img,1) * size(img,2);
   
   %probability list
   p = zeros(256,1);
   freq = zeros(256,1);
 
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
function c = cfd(l)
   c = zeros(length(l),1);
   size(l(1,1))
   disp(['size l ' num2str(size(l))]);
   %calculate the cumulative probs by adding
   for i = 2:length(l)
      c(i) = l(i,1) + c(i - 1);
   end
   
end