[gifImage cmap] = imread('map.gif');
rgbImage = ind2rgb(gifImage, cmap);
gray = ind2gray(gifImage, cmap);
imshow(gray);
size(gray)

out = zeros(size(gray));
%midX = round(size(gray,1)/2);
%midY = round(size(gray,2)/2;

%{
for j = 1:size(gray,2)
    inY = sin(j);
    inY = (inY - min(inY))/(
    out(:,j) = gray(:,

end
%}