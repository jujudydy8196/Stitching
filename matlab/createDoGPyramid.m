function [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels)


DoGPyramid = zeros([size(GaussianPyramid,1),size(GaussianPyramid,2),length(levels)-1]);
DoGLevels = levels(2:length(levels));

for i = 2:length(levels)
    DoGPyramid(:,:,i-1) = GaussianPyramid(:,:,i)-GaussianPyramid(:,:,i-1);
end

end

