function [locs, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, th_contrast,th_r)

% im = imread(im);
im = im2double(im);
if size(im,3)==3
    im= rgb2gray(im);
end

GaussianPyramid = createGaussianPyramid(im, sigma0, k, levels);
% figure;
% displayPyramid(GaussianPyramid);
[DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);
% figure;
% displayPyramid(DoGPyramid);
PrincipalCurvature = computePrincipalCurvature(DoGPyramid);
%figure;
%imshow(im);
%hold on;
locs = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r);
% figure
% imshow(im)
% hold on
% scatter(locs(:,1),locs(:,2),'filled')


end

