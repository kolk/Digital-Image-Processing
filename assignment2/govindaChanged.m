
function govinda()
%% input reading
tic
img = imread('vegan-modified.jpg');
figure;
imshow(img);
img = double(imresize(img,0.5));
windowSize = size(img);
template = imread('soy-dessert.jpg');
template = double(imresize(template,0.5));
windowSize = size(template);
windowArea = size(template,1) * size(template,2);

integralSum = integralImg(img);
integralSquare = integralImg(img.^2);

temDiff = template(:) - mean(template(:));
temStd = std(template);
%% normalized cross correlation
maxResult = 0;
result = ones(size(img))*255;
[Nx,Ny] = size(template);
for i = 1 : size(img,1) -Nx
	for j = 1 : size(img,2) - Ny
                lastX  = i + windowSize(1)-1;
                lastY = j + windowSize(2)-1;
		I = img(i:lastX ,j:lastY);
                areaI = (integralSum(lastX ,lastX ) + integralSum(i,j) - integralSum(lastX ,j) - integralSum(i,lastX));
		avgI = areaI ./ (windowArea);
		meanZeroI = I- avgI;%bsxfun(@minus,block,avgI);
		numerator = meanZeroI(:)' * temDiff(:);
		%denominator = sqrt(integralSquare(i+Nx-1,j+Ny-1) + integralSquare(i,j) -integralSquare(i+Nx-1,j) -integralSquare(i,j+Ny-1)) ;
                denominator = integralSquare(i+Nx-1,j+Ny-1) + integralSquare(i,j) -integralSquare(i+Nx-1,j) -integralSquare(i,j+Ny-1) ;
                denominator = sqrt((denominator - (areaI^2/windowArea))*temStd);
size(numerator)
size(denominator)
		result(i,j) = numerator / denominator;
               
		if maxResult < result(i,j)
			maxResult = result(i,j);
			x = i; y = j;
		end
	end
end
x
y
drawnow;
   hold on;
   figure;
   imshow(mat2gray(img));
   rectangle('Position', [y , x , windowSize(2), windowSize(1)], 'EdgeColor', 'r', 'LineWidth', 2);
   %figure;
   %imshow(mat2gray(result));
toc
end


function integral = integralImg(img)
   integral = zeros(size(img));
   integral = [zeros(size(integral,1),1) integral];
   integral = [zeros(1,size(integral,2)); integral];
   for j = 1: size(img,2)
       for i = 1: size(img,1)
          integral(i+1,j+1) = img(i,j) + integral(i, j+1) + integral(i+1, j) - integral(i,j);
       end
   end
end


