clc
clear all
close all



original_image = imread('silverNewT.jpeg');
background_image = imread('backgroundT.jpeg');  
new = imabsdiff(original_image,background_image)
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



a = grayImage;                                                                                                                 
optimal_threshold = graythresh(a);                                                                                                                                                                                                                             %normalized form. 
b = imbinarize(a,optimal_threshold);                                                                                             
                      
cc=bwconncomp(b);                               
cc2=bwconncomp(not(b)); 
stats= regionprops(cc, 'Perimeter');
stats2= regionprops(cc2, 'Perimeter');                                                                                          
idx =find([stats.Perimeter]> 4200);                                                                                             
                                                                                                                                
binImage2 =ismember(labelmatrix(cc),idx);                                                                                       

idx2 =find([stats2.Perimeter]< 4200 & [stats2.Perimeter]> 600);                                                                 
                                                                                                                                
binImage3 =ismember(labelmatrix(cc2),idx2);                                                                                     
stats3 = regionprops('table',binImage2, 'MajorAxisLength','MinorAxisLength', 'Perimeter', 'Area', 'EquivDiameter', 'Centroid') 
stats4 = regionprops('table',binImage3, 'MajorAxisLength','MinorAxisLength', 'Perimeter', 'Area', 'EquivDiameter', 'Centroid') 
                                 
final= bwlabel(b);                                      
figure 

subplot(3, 2, 1); 
imshow(original_image);                         
title(['Original image']);
subplot(3, 2, 2);
imshow(grayImage);                              
title(['GrayScale image']);
subplot(3, 2, 3);
imshow(binImage2);                              
title('Image filter oil drum');
subplot(3, 2, 4);
imshow(binImage3);                              
title('Image filter filling hole');
subplot(3, 2, 5);
imshow(b);                                      
title('Image filter filling DRUM');