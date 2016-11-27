function bilateralFilt()
   img = imread('face.png');
   %img = single(img);
   figure(1);
   imshow(img); %s = gaussian2d(5, 0.1);
   %img = [100, 443, 80; 80, 440, 90; 87, 445, 79]
  
   out = gaussian2dIntensity(5, 1, img);
    %closeFilt = 
 
end

function filter = gaussian2d(n, sig)
   [x,y] = meshgrid(ceil(-n/2):floor(n/2), ceil(-n/2):floor(n/2))
   filter = exp(-(x.^2 + y.^2)/(2*sig^2))
end

function filter = gaussian2dIntensity(n, sig, img)
   gaussFilt = gaussian2d(n, sig);
   s = size(img);
   
   img = [zeros(size(img,1),floor(n/2)) img zeros(size(img,1),floor(n/2))];
   img = [zeros(floor(n/2), size(img,2)); img; zeros(floor(n/2), size(img,2))];
   img = double(img);
   out = zeros(s);
   for i = 1:s(1)
       for j = 1:s(2)
           %make the filter
           filter = double(zeros(n,n));
           
           mid = img(i+ floor(n/2),j+floor(n/2));
           for p = 1:round(n)
               for q = 1:round(n)
                  sub = ((mid - img(i+p - 1, j+q - 1)));
                  filter(p,q) = exp(-sub^2/(2*sig^2));
              end
           end
           
                    
           %apply filter on patch
           size(gaussFilt);
           size(filter);
           F = filter .* gaussFilt;
           I = img(i:i+ n-1, j:j +n-1);
           out(i,j) =  sum(F(:) .* I(:))/sum(F(:));
       end
   end
   figure(2);
   imshow(uint8(out));
end