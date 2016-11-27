%The bottle which is not filled properly has a larger white region for the
%empty space. This is the largest connected component in the entire image.
%The correctly filled bottles have relatively lower size of connected
%components but still are larger than random noise connected compoenents.
%To classify a bottle as improperly filled I have taken the average of the
%largest ccs and any ccs larger than the average is incorrectly filled.

close all;
im = imread('bottles.tif');

%convert to binary image
bw = im2bw(im,0.7);

%find connected components
cc = bwconncomp(bw);

%find number of pixels in ccs
numPixels = cellfun(@numel,cc.PixelIdxList);

%sort blobs based on size
[sortedPix, index] = sort(numPixels, 'descend');

%find large blobs
numBottles = size(find(sortedPix > 1000),2);

%average of empy regions around bottles
correctAr = sum(sortedPix(1:numBottles))/numBottles;

%find bounding box coordinates around the blobs
ms = regionprops(cc, 'BoundingBox');
ms = ms(index);

figure;
imshow(im);
drawnow;
hold on;

for blobNumber = 1:length(ms)
        %rectangle('Position', ms(1).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
        if sortedPix(blobNumber) > correctAr
            rectangle('Position', ms(blobNumber).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 2);7
        else
            break;
        end
end
hold off;