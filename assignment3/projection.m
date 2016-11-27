close all;
[gifImage cmap] = imread('map.gif');
gray = ind2gray(gifImage, cmap);
imshow(gray);
[row, col] = size(gray);

%%
cylindrical = zeros(size(gray));
mercator = zeros(size(gray));
mval = [];
val = [];

for j = 1:size(gray,1)
   newX = round((sin((j - row/2)/(row/2)) * (row/pi) ) + (row/2)) + 1;
   
   val = [val newX];
   min(newX(:));
   cylindrical(newX,:)  = gray(j,:); 
   
   %{
   j0 = (j - row/2); %j0 => [-359,360]
   
   %j0 = j0*pi/2 - pi/4; % =>[-3pi/4,pi/4]
   j0 = pi*j/(2*row); %=>radians
   disp(['j ' num2str(j) ' jo ' num2str(j0)]);
   newX = log((tan(pi/4 + j0/2)));
   
   %disp(['j ' num2str(j) ' j0 ' num2str(j0) ' tan ' num2str(tan(pi/4 + j0/2))])
   newX = round(newX*row*2/pi) + row/2 + 1;
   %newX = round(log(abs(tan(pi/4 + j0/2)) + 1)) + 1
   %mercator(newX,:) = gray(j,:);
   
   mval = [mval newX];
  %}
   
end
figure;
imshow(cylindrical);
intp = setdiff(1:size(gray,1), val);
out = cylindrical(unique(val),:);
figure;
imshow(out);

%{
mval = round((mval-min(mval(:)))*720/(max(mval(:))-min(mval(:)))) + 1 ;
mval(mval == 721) = 720;
size(mval)
mercator(round(mval)+1,:)= gray(1:size(gray,1),:); 
%}
%mval = round(real(mval));
%mval = mval - min(mval);
%min(mval)
%max(mval)
%mval
%{
mercator(mval,:) = gray(1:row,:);
%mercator(mval+1,:) = gray(:,:);
ntp = setdiff(1:size(gray,1), mval);
out = mercator(unique(mval),:);
figure;
imshow(mat2gray(mercator));
%}
%{
I = mat2gray(imread('map.gif'));
[m,n] = size(I);

%% Mercator Transformation (x,y) --> (x,ln tan(pi/4 + y/2))

mat = [1:m]-m/2;
y = (mat)*(pi/2) / (max(mat)) ;    % in radians
ynew = log(tan(pi/4 + y/2));    % Transformation
Mat = (ynew/(pi/2)) * (max(mat));   % Remapping to ractangular co-ordinates

xnew = round(Mat - min(Mat)+1);

%% Interpolation
MT(1,:) = I(1,:);
for i=2:m-2
    %MT(xnew(i),:) = I(i,:);
     %MT(xnew(i-1)+1:xnew(i),:) = repmat(I(i,:),xnew(i)-xnew(i-1),1);
end

figure;
imshow(MT);
%}