clear;
close all;
im = rgb2gray(imread('circles.jpg'));
se = strel('disk',2);
afterOpening = imopen(im,se);
figure;
imshow(im);
im = afterOpening;

imBW = im2bw(im, 0.15);
figure;
imshow(imBW);

%connected components of each image
cc = bwconncomp(imBW, 8);

%label matrix of each connected component
L = labelmatrix(cc);

%num of pixels in each connected component
areasInPixels = cellfun(@length, cc.PixelIdxList);

%convert area into radius 
aPix = ceil(sqrt(areasInPixels/pi));

%unique radii
catSize = unique(aPix);

%number of unique radii
catNum = size(catSize,2);

%number of ccs for various radii
countSz = zeros(max(catSize),1);
[sortedArea, indices] = sort(aPix);
for i = 1:length(sortedArea)
    countSz(sortedArea(i)) =  countSz(sortedArea(i)) + 1;    
end
countSz = countSz(catSize);

disp(['number of circle categories based on radius ' num2str(catNum)]);

%display circle categories based on size
disp('different cicle sizes');
disp(catSize);

%display number of members in each category
for i = 1:length(catSize)
    disp([num2str(countSz(i)) ' circles have size ' num2str(catSize(i)) ]);
end

%find ccs for each area
for i = 1:catNum
    idx = find(aPix == catSize(i));
    bw2 = ismember(L, idx);
    figure;
    imshow(bw2);
    title(['Circle radius ' num2str(catSize(i))]);
end