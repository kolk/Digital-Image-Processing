clc; clear all;
colormap('gray');
L=256;
x0=imread('office.jpg');
x0=double(x0); %input image
[m,n]=size(x0);
len=m*n; %number of pixels
x=reshape(x0,len,1); %convert to [len:1]
xpdf=hist(x,[0:L-1]) % pdf, 1 x L
xpdf=xpdf/len;%Normalize it to get nk/n (eq 3.3-7)....(len is equal to sum(xpdf), number %of pixels...)
sk=xpdf*triu(ones(L));%CDF (eq 3.3-8), (eq 3.3-13) 
%Histogram Specification
zd_pdf(1:L)=1; %desired histogram of output image
ext = sin(0:pi/255:pi);
zd_pdf=zd_pdf+ext; %desired histogram of output image
zd_pdf = zd_pdf / sum(zd_pdf); %normalize
zk=zd_pdf*triu(ones(L)); %G(z), CDF (eq 3.3-14)
%iteration(eq 3.3-17) % hist. matching
mapping=zeros(256);
z0=zeros(m,n);
for q=1:L
 for p=mapping(q)+1:L
 if ((zk(p)-sk(q)) >= 0)
 mapping(q) = p;
 list=find(x0 == q-1); a=size(list);%find value
%in input image
 z0(list)=p; %map sk value for each k valued
%pixel
 break;
 end
 end
end
z=reshape(z0,len,1); %convert to [len:1]
zpdf=hist(z,[0:L-1])/len; % pdf, 1 x L
figure(1),subplot(411),stem([0:L-1],xpdf,'.'),title('histogram, original')
subplot(412),stem([0:L-1],zd_pdf,'.'),title('desired pdf')
subplot(413),stem([0:L-1],zk,'.'),title('transformation')
subplot(414),stem([0:L-1],zpdf,'.'),title('histogram,matched')
figure(2);
colormap('gray');
image(z0);
z0=uint8(z0);
imwrite(z0,'Lvr2i_match.tif','TIFF'); 