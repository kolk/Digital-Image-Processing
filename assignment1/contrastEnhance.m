function contrastEnhance()
   img = imread('chip.jpg');
   
   figure(1);
   title('original');
   imshow(img);
   %{
   img = 255-img;
   
   img = imadjust(img,stretchlim(img),[]);
   imshow(imhist(img));
   img = histeq(img);
   figure(2);
   imshow(img);
   
   h = fspecial('laplacian', 0.2);
   s = single(img);
   g = imfilter( s , h, 'replicate') ;
   figure(3);
   imshow(g);
   figure(4);
   imshow(s+g);
   figure(5);
   imshow(s-g);
   %}
   unsharpMasking(img);
   
   %figure(3);
   %res = medfilt2(img, [3 3]);
   %imshow(res);
 
   
   

end