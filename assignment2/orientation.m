function orientation()
   clc
   clear all
   close all
   findAngle(imread('test-images-for-q2/son3.gif'));
   findAngle(imread('test-images-for-q2/son3rot1.gif'));
   findAngle(imread('test-images-for-q2/son3rot2.gif'));
   findAngle(imread('test-images-for-q2/son3rot3.gif'));
 
end
   

function findAngle(img1)

    %shifted fourier transform of image  
    img1fft = fftshift(fft2(img1));
    
    %magnitude of transform
    absimg1 = abs(img1fft);
   
    %binary image of magnitude
    b = im2bw(mat2gray(absimg1),0.05);

    %connected components of binary image
    cc = bwconncomp(b,8);
    ms = regionprops(cc, 'BoundingBox');
    
    %list cc based on size of cc in descending order
    pixelCount = cellfun(@numel,cc.PixelIdxList);
    [sorted,idx] = sort(pixelCount, 'descend');


    %draw bounding boxes around all blobs
    figure;
    subplot(221),imshow(img1,[]);
    title('Original Image');
    subplot(222), imshow(b);
    title('Clusters of highest frequency');
    hold on;
    
    %find top 3 largest ccs and their centers
    I = zeros(1,3);
    J = zeros(1,3);
    for blobNumber = 1:3
        recCoords =  ms(idx(blobNumber)).BoundingBox;
        rectangle('Position', recCoords, 'EdgeColor', 'r', 'LineWidth', 2);
        J(blobNumber) = recCoords(1) + recCoords(3)/2;
        I(blobNumber) = recCoords(2) + recCoords(4)/2;

    end
   
   %fit a line around the centers of top 3 largest ccs
   line = fit(I',J','poly1');
  
   %slope of the line is the orientation of the image 
   angle = round(atan(line.p1)*180/pi)
   subplot(223), plot(line,I, J);
   title(['Orientation of image ' num2str(angle)]);
    
   
end