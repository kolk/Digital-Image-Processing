clc
clear all
close all

%% Map Transformation
I = mat2gray(imread('map.gif'));
[m,n] = size(I);

%% Mercator Transformation (x,y) --> (x,ln tan(pi/4 + y/2))
% mat = [1:m/2];
% y = (mat)*(pi/2) / (max(mat)) ;    % in radians
% ynew = log(tan((pi/4)+(y/2)));      % Transformation
% Mat = (ynew/(pi/2)) * (max(mat));   % Remapping to ractangular co-ordinates

mat = [1:m]-m/2;
y = (mat)*((85/90) * pi/2) / (max(mat)) ;    % in radians
ynew = log(tan((pi/4)+(y/2)));      % Transformation
Mat = (ynew/((85/90) * pi/2)) * (max(mat));   % Remapping to ractangular co-ordinates

xnew = round(Mat - min(Mat)+1);

% Interpolation
MT(1,:) = I(1,:);
for i=2:m-2
    MT(xnew(i),:) = I(i,:);
    MT(xnew(i-1)+1:xnew(i),:) = repmat(I(i,:),xnew(i)-xnew(i-1),1);
end


I2 = imresize(MT,[m,n]);
figure;
imshow(mat2gray(MT));

