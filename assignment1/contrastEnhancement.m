function contrastEnhancement
   img = imread('chip.png');
   figure;
   imshow(img);
   
   %power transformation of image
   imgPowerTrasnformed =  4 .* img .^2;
   figure;
   imshow(imgPowerTrasnformed);
   
   %power transformation and strecting of image
   imgPowerTrasnformed2 =  2 .* img .^3;
   imgStretched = imadjust(imgPowerTrasnformed2, stretchlim(imgPowerTrasnformed),[0 1]);
   figure;
   imshow(imgStretched); 
   
   %adaptive histogram equalization on local windows of power transformed
   %image
   img1 = adapthisteq(img, 'clipLimit',0.05,'Distribution','rayleigh');
   img2 = adapthisteq(img1, 'clipLimit',0.05,'Distribution','uniform');
   figure;
   imshow(img2);
   
   
   
   
   
end


