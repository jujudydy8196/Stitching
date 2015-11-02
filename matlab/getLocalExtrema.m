function locs = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r)

idx = [find(imregionalmax(DoGPyramid,26)==1); find(imregionalmin(DoGPyramid,26)==1)];

idx_1 = [find(abs(DoGPyramid(idx))>th_contrast & PrincipalCurvature(idx)<th_r)];
[row,col,level]=ind2sub(size(DoGPyramid),idx(idx_1));
locs = [col row DoGLevels(level)'];


end

