clc
clear all
threshold = 90;
f= imread('Luchiano.jpg');
grayImage=rgb2gray(f);
g= imbinarize(grayImage,threshold/255);

[pixelCount,grayLevels] = imhist(grayImage);    %Calculation of the Histogram.
max_value = max(max(grayImage));                %The absolute maximum value in the image. 
min_value = min(min(grayImage));                %The absolute minimum value in the image. 
max_pixelcount = max(pixelCount);               %Find the maximum pixel count. 
min_pixelcount = min(pixelCount);               %Find the minimum pixel count. 
[~, x] = max(pixelCount);                       %Find the gray level at which the largest amount of the pixels are. 
[~, y] = min(pixelCount);                       %Find the gray level at which the least amount of pixels are. 
level_with_max = grayLevels(x);                 %Store in a variable the gray level at which the largest amount of the pixels are. 
level_with_min = grayLevels(y);  

cc=bwconncomp(g);                               %Find the components of the binary image
cc2=bwconncomp(not(g)); 
stats= regionprops(cc, 'Perimeter');
stats2= regionprops(cc2, 'Perimeter');%Obtain the perimeter of the components found
idx =find([stats.Perimeter]> 4200);              %Filter the image for just the components Grande
                                                %with a perimeter bigger than 360
binImage2 =ismember(labelmatrix(cc),idx);       %Create a new image filtered

idx2 =find([stats2.Perimeter]< 350 & [stats2.Perimeter]> 300);             %Filter the image for just the components 
                                                %with a perimeter bigger than 360
binImage3 =ismember(labelmatrix(cc2),idx2);      %Create a new image filtered Pequeño

stats3 = regionprops('table',binImage2, 'MajorAxisLength','MinorAxisLength', 'Perimeter', 'Area', 'EquivDiameter', 'Centroid') %obtain properties for the image
stats4 = regionprops('table',binImage3, 'MajorAxisLength','MinorAxisLength', 'Perimeter', 'Area', 'EquivDiameter', 'Centroid') %obtain properties for the image
                                 
final= bwlabel(g);  

figure
subplot(2,2,1);
imshow(f)
title(['Original image']);
subplot(2,2,2);
imshow(g)
title(['GrayScale image']);
subplot(2, 2, 3);
imshow(binImage2);                              %Display the segmented image image with filter to show big coins
title('Image filter oil drum');
subplot(2, 2, 4);
imshow(binImage3);                              %Display the segmented image image with filter to show small coins
title('Image filter filling hole');
