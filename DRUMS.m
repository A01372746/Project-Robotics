clc
clear all
close all

original_image = imread('NewCam.jpeg');                                                                                        
grayImage = rgb2gray(original_image);
[pixelCount,grayLevels] = imhist(grayImage);                                                                                   
max_value = max(max(grayImage));                                                                                                
min_value = min(min(grayImage));                                                                                                 
max_pixelcount = max(pixelCount);                                                                                               
min_pixelcount = min(pixelCount);                                                                                               
[~, x] = max(pixelCount);                                                                                                       
[~, y] = min(pixelCount);                                                                                                       
level_with_max = grayLevels(x);                                                                                                  
level_with_min = grayLevels(y);

threshold = 90;
g= imbinarize(grayImage,threshold/255);



a = grayImage;                                                                                                                 
optimal_threshold = graythresh(a);                                                                                                                                                                                                                             %normalized form. 
b = imbinarize(a,optimal_threshold);                                                                                             
                      
cc=bwconncomp(not(b));                               
stats= regionprops(cc, 'Perimeter','Centroid');
idx =find([stats.Perimeter]< 6000 &[stats.Perimeter]> 5000); 
binImage2 =ismember(labelmatrix(cc),idx);
stats3 = regionprops(binImage2, 'MajorAxisLength','MinorAxisLength', 'Perimeter', 'Area', 'EquivDiameter', 'Centroid')
centroidsB = cat(1,stats3.Centroid)
centers = stats3.Centroid; diameters = mean([stats3.MajorAxisLength stats3.MinorAxisLength],2); 
radii = diameters/2

cc2=bwconncomp(not(g)); 
stats2= regionprops(cc2, 'Perimeter');                                                                                          
idx2 =find([stats2.Perimeter]< 350 & [stats2.Perimeter]> 315);                                                                                                                                                                                                 
binImage3 =ismember(labelmatrix(cc2),idx2);                                                                                     
stats4 = regionprops('table',binImage3, 'MajorAxisLength','MinorAxisLength', 'Perimeter', 'Area', 'EquivDiameter', 'Centroid')
centroidsH = cat(1,stats4.Centroid)
centers2 = stats4.Centroid; diameters2 = mean([stats4.MajorAxisLength stats4.MinorAxisLength],2); 
radii2 = diameters2/2

final= bwlabel(b);                                      
figure 

subplot(2, 3, 1); 
imshow(original_image);                         
title(['Original image']);
subplot(2, 3, 2);
imshow(grayImage);                              
title(['GrayScale image']);
subplot(2, 3, 3);
imshow(b);                              
title('Binarized');
subplot(2, 3, 5);
imshow(binImage2);
hold on
plot(centroidsB(:,1),centroidsB(:,2),'r*')
viscircles(centers,radii);
hold off
title('Image filter DRUM');
subplot(2, 3, 6);
imshow(binImage3);
hold on
plot(centroidsH(:,1),centroidsH(:,2),'r*')
viscircles(centers2,radii2);
hold off
title('Image filter HOLE');
