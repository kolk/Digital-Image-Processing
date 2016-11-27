     

function out = translate()
    close all;
  im = imread('chromakey.jpg');
    figure;
    imshow(im);
    a = 20;
    b = 25;
    im = rgb2gray(im);
    
    out = zeros(size(im));
    for i = 1:size(im,1)-a
        for j = 1:size(im,2)-b
            out(i+a,j+b) = im(i,j);
        end
    end
    
    figure;
    imshow(mat2gray(out));
end
    
function scale()
    
    im = imread('chromakey.jpg');
    figure;
    imshow(im);
    x = 2;
    y = 1.5;
    sc = [x 0; 0 y]; 
    im = rgb2gray(im);
    out = sc * im
end