function imgDiff()
  %find the variation in image set 1
  img1 = imread('spot1-diff1.jpg'); 
  img2 = imread('spot1-diff2.jpg');
  diff(img1, img2,1);
  
  %find the variation in image set 2
  img1 = imread('spot2-diff1.png');
  img2 = imread('spot2-diff2.png');
  diff(img1, img2,2);
end


function diff(img1, img2, i)
%read the images
r = img1-img2;

%convert rgb to binary with 0.05 lumiance level threholding
b = im2bw(r, 0.05);

%show the image
figure;
imshow(img1);
drawnow;
hold on;

%find the connected components blobs
cc = bwconncomp(b);

%dfind bounding box coordinates around the blobs
ms = regionprops(cc, 'BoundingBox');

%draw bounding boxes around all blobs
if length(ms) == 0
    fprintf('The images are exactly the same');
    
else
    for blobNumber = 1:length(ms)
        %rectangle('Position', ms(1).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
        rectangle('Position', ms(blobNumber).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
    end
end

end


