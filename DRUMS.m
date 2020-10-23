clc
clear all
close all



original_image = imread('silverNewF.jpeg');
background_image = imread('backgroundF.jpeg');  
new = imabsdiff(original_image,background_image);
grayImage = rgb2gray(new);
[pixelCount,grayLevels] = imhist(grayImage);                                                                                   
max_value = max(max(grayImage));                                                                                                
min_value = min(min(grayImage));                                                                                                 
max_pixelcount = max(pixelCount);                                                                                               
min_pixelcount = min(pixelCount);                                                                                               
[~, x] = max(pixelCount);                                                                                                       
[~, y] = min(pixelCount);                                                                                                       
level_with_max = grayLevels(x);                                                                                                  
level_with_min = grayLevels(y);                                                                                                 


o = grayImage;
a = grayImage;                                                                                                                 
optimal_threshold = graythresh(a);                                                                                                                                                                                                                             %normalized form. 
b = imbinarize(a,optimal_threshold);                                                                                             
                      
cc=bwconncomp(not(b));                               
cc2=bwconncomp(b); 
stats= regionprops(cc, 'Perimeter');
stats2= regionprops(cc2, 'Perimeter');                                                                                          
idx =find([stats.Perimeter]> 8000);                                                                                             
                                                                                                                                
binImage2 =ismember(labelmatrix(cc),idx);                                                                                       

idx2 =find([stats2.Perimeter]< 3500 & [stats2.Perimeter]> 800);                                                                 
                                                                                                                                
binImage3 =ismember(labelmatrix(cc2),idx2);                                                                                     
stats3 = regionprops('table',binImage2, 'MajorAxisLength','MinorAxisLength', 'Perimeter', 'Area', 'EquivDiameter', 'Centroid') 
stats4 = regionprops('table',binImage3, 'MajorAxisLength','MinorAxisLength', 'Perimeter', 'Area', 'EquivDiameter', 'Centroid') 
                                 
final= bwlabel(b);                                      
figure 

subplot(3, 2, 1); 
imshow(original_image);     %original                     
title(['Original image']);
subplot(3, 2, 2);
imshow(new);                    %          
title(['Image without background']);
subplot(3, 2, 3);
imshow(b);                              
title('Binarized');
subplot(3, 2, 4);
imshow(binImage2);                              
title('Image filter filling drum');
subplot(3, 2, 5);
imshow(binImage3);                                      
title('Image filter filling hole');