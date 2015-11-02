function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)

PrincipalCurvature = zeros(size(DoGPyramid));

for l=1:size(DoGPyramid,3)
    [Dx,Dy] = imgradientxy(DoGPyramid(:,:,l),'CentralDifference');
    [Dxx,Dxy] = imgradientxy(Dx,'CentralDifference');
    [Dyx,Dyy] = imgradientxy(Dy,'CentralDifference');
    PrincipalCurvature(:,:,l) = (Dxx+Dyy).^2./((Dxx.*Dyy)-(Dxy).^2);
end

