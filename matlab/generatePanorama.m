function im3 = generatePanorama(img1, img2)

% sigma0=1; k=sqrt(2); levels=[-1 0 1 2 3 4]; th_contrast=0.03; th_r=12;
im1color = imread(img1);
im1 = im2double(im1color);
if size(im1color,3)==3
    im1= rgb2gray(im1color);
else
    im1=im1color;
end
im2color = imread(img2);
im2color = im2double(im2color);
if size(im2color,3)==3
    im2= rgb2gray(im2color);
else
    im2=im2color;
end

[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
matches = briefMatch(desc1, desc2);


bestH = ransacH(matches, locs1, locs2, 1000, 20);
% im3 = imageStitching(im1color, im2color, bestH);
im3 = imageStitching_noClip(im1color, im2color, bestH);
figure
imshow(im3);
end
