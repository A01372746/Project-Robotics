clc
clear all
close all

original_image = imread('Silver.jpeg'); %Read the image and store the values in a matrix 'grayImage'. 
grayImage = rgb2gray(original_image);
[pixelCount,grayLevels] = imhist(grayImage);    %Calculation of the Histogram.
max_value = max(max(grayImage));                %The absolute maximum value in the image. 
min_value = min(min(grayImage));                %The absolute minimum value in the image. 
max_pixelcount = max(pixelCount);               %Find the maximum pixel count. 
min_pixelcount = min(pixelCount);               %Find the minimum pixel count. 
[~, x] = max(pixelCount);                       %Find the gray level at which the largest amount of the pixels are. 
[~, y] = min(pixelCount);                       %Find the gray level at which the least amount of pixels are. 
level_with_max = grayLevels(x);                 %Store in a variable the gray level at which the largest amount of the pixels are. 
level_with_min = grayLevels(y);                 %Store in a variable the gray level at which the least amount of pixels are.

%Manual Threshold
threshold = 95;                                 %Establishing a threshold in a grayscale from 0 to 255 graylevels.
f = grayImage;                                  %Read the grayscale image and store the values in a matrix 'f'.
g = imbinarize(f,threshold/255);                %Generating the segmented image 'g' using the threshold.
                                                %All the pixels with values above the threshold in the image 'f' will be ones (1s) in
                                                %the segmented image 'g'. The rest will be zeros (0s).
                                                %The value for the threshold is required to be introduced in normalized
                                                %form.





%Otsu

a = grayImage;                                  %Read the grayscale image and store the values in a matrix ‘a'.
optimal_threshold = graythresh(a);              %From mathworks: The graythresh function uses Otsu's method, which                                    
                                                %chooses the threshold to minimize the intra-class variance of the                                    
                                                %pixels. The variable 'optimal_threshold' is delivered in                                   
                                                %normalized form. 
b = imbinarize(a,optimal_threshold);            %Generating the segmented image 'b' using the optimal threshold.                   
                                                %All the pixels with values above the optimal threshold in the image 'a' will be                    
                                                %ones (1s) in the segmented image 'b'. The rest will be zeros (0s).                  
                                                %The result is a binarized image with Otsu's Method, as we used the optimal threshold                    
                                                %that minimizes the intra-class variance and maximizes the inter-class variance.                   
%Parte 6                                        


cc=bwconncomp(b);                               %Find the components of the binary image
cc2=bwconncomp(not(b)); 
stats= regionprops(cc, 'Perimeter');
stats2= regionprops(cc2, 'Perimeter');%Obtain the perimeter of the components found
idx =find([stats.Perimeter]> 4200);              %Filter the image for just the components Grande
                                                %with a perimeter bigger than 360
binImage2 =ismember(labelmatrix(cc),idx);       %Create a new image filtered

idx2 =find([stats2.Perimeter]< 4200 & [stats2.Perimeter]> 600);             %Filter the image for just the components 
                                                %with a perimeter bigger than 360
binImage3 =ismember(labelmatrix(cc2),idx2);      %Create a new image filtered Pequeño
stats3 = regionprops('table',binImage2, 'MajorAxisLength','MinorAxisLength', 'Perimeter', 'Area', 'EquivDiameter', 'Centroid') %obtain properties for the image
stats4 = regionprops('table',binImage3, 'MajorAxisLength','MinorAxisLength', 'Perimeter', 'Area', 'EquivDiameter', 'Centroid') %obtain properties for the image
                                 
final= bwlabel(b);                                      
figure 

subplot(2, 2, 1); 
imshow(original_image);                         %Display the grayscale image.
title(['Original image']);

subplot(2, 2, 2);
imshow(grayImage);                              %Display the grayscale image.
title(['GrayScale image']);


subplot(2, 2, 3);
imshow(binImage2);                              %Display the segmented image image with filter to show big coins
title('Image filter oil drum');

subplot(2, 2, 4);
imshow(binImage3);                              %Display the segmented image image with filter to show small coins
title('Image filter filling hole');