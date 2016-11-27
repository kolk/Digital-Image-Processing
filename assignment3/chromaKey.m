clc;
close all;

%% read the images
i = imread('/home/vaishali/Documents/courses/DIPCourse/assignment3/me2.jpg');
figure;
imshow(i);

b = imread('/home/vaishali/Desktop/colosseum.jpg');
figure;
imshow(b);

%reszie the image
i = imresize(i, 0.125);

%% embed person in background image



% coordinates for translation of foreground image
x = size(b,1)-size(i,1);
y = size(b,2)-size(i,2);

%insert person image in background image
for p = 1:size(i,1)
    for q = 1:size(i,2)
        if(~(i(p,q,1) > 110 && i(p,q,2) > 110 && i(p,q,3) > 110 && i(p,q,1) < 200 && i(p,q,2) < 200 && i(p,q,3) < 200))
            b(p+x,q,:) = i(p,q,:);
        end
        
    end
end
figure;
imshow(b);
