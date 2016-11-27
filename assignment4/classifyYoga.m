function classifYoga()
   close all;
   clc;
   im1 = imread('yogasan/y1.jpg');
   im2 = imread('yogasan/y2.jpg');
   im3 = imread('yogasan/y3.jpg');
   im4 = imread('yogasan/y4.jpg');
   y1 = load('1.mat');
   y1 = y1.nChain;
   y2 = load('2.mat');
   y2 = y2.nChain;
   y3 = load('3.mat');
   y3 = y3.nChain;
   y4 = load('4.mat');
   y4 = y4.nChain;
   
   bw1 = im2bw(im1);
   bw1 = 1 - bw1;
   bd = boundary(bw1);
   chain = getChain(bd);
   nChain = normalizeChain(chain);
   disp('image 1 is equal to: ');
   disp(['y1? ' num2str(isequal(nChain, y1))]);
   disp(['y2? ' num2str(isequal(nChain, y2))]);
   disp(['y3? ' num2str(isequal(nChain, y3))]);
   disp(['y4? ' num2str(isequal(nChain, y4))]);
   
   
   bw2 = im2bw(im2);
   bw2 = 1 - bw2;
   bd = boundary(bw2);
   chain = getChain(bd);
   nChain = normalizeChain(chain);
   disp('image 2 is equal to: ');
   disp(['y1? ' num2str(isequal(nChain, y1))]);
   disp(['y2? ' num2str(isequal(nChain, y2))]);
   disp(['y3? ' num2str(isequal(nChain, y3))]);
   disp(['y4? ' num2str(isequal(nChain, y4))]);
   
   bw3 = im2bw(im3);
   bw3 = 1 - bw3;
   bd = boundary(bw3);
   chain = getChain(bd);
   nChain = normalizeChain(chain);
   disp('image 3 is equal to: ');
   disp(['y1? ' num2str(isequal(nChain, y1))]);
   disp(['y2? ' num2str(isequal(nChain, y2))]);
   disp(['y3? ' num2str(isequal(nChain, y3))]);
   disp(['y4? ' num2str(isequal(nChain, y4))]);

   
   bw4 = im2bw(im4);
   bw4 = 1 - bw4;
   bd = boundary(bw4);
   chain = getChain(bd);
   nChain = normalizeChain(chain);
     disp('image 4 is equal to: ');
   disp(['y1? ' num2str(isequal(nChain, y1))]);
   disp(['y2? ' num2str(isequal(nChain, y2))]);
   disp(['y3? ' num2str(isequal(nChain, y3))]);
   disp(['y4? ' num2str(isequal(nChain, y4))]);


 
  
end
