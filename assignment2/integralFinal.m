clc;

imgOrg = imread('vegan.jpg');   
imgOrg = double(imresize(imgOrg, 0.5));
img = [5 2 5 2; 3 6 3 6; 5 2 5 2; 3 6 3 6];

%% integral images
 integralSum = integralImage(img)
 integralSquare = integralImage(img.^2);
 

 %% template image
 template = double(imresize(imread('soy-dessert.jpg'), 0.5));
 windowSize = size(template);
 windowArea = size(template,1) * size(template,2);
 mnTemplate = mean(template(:));
 stdTemplate = std(template(:));
 tempDiff = template(:) - mnTemplate;
 
 maxVal = 0;
 result = zeros(size(imgOrg));
 resMax = 0;
 

for u = 1 : size(img,1) -  windowSize(1)
	for v = 1 : size(img,2) -  windowSize(2)
		block = img(u:u+Nx-1,v:v+Ny-1);
		img_avg = (s1(u+Nx-1,v+Ny-1) + s1(u,v) - s1(u+Nx-1,v) - s1(u,v+Ny-1)) ./ (Nx*Ny);
		block = bsxfun(@minus,block,img_avg);
		gamma_n = sum(block(:) .* img_temp_mean(:));
		gamma_d = (s2(u+Nx-1,v+Ny-1) + s2(u,v) -s2(u+Nx-1,v) -s2(u,v+Ny-1)) .^ (1/2);
		gamma = gamma_n ./ gamma_d;
		if best_gamma < gamma
			best_gamma = gamma;
			x = u; y = v;
		end
	end
end