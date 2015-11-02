function [locs, desc] = briefLite(im)

levels = [-1 0 1 2 3 4];
load('testPattern.mat','compareX','compareY');
[locs, GaussianPyramid] = DoGdetector(im, 1, sqrt(2),levels, 0.03,12);
[locs,desc] = computeBrief(im, locs, levels, compareX, compareY);

end

