function [panoImg] = imageStitching_noClip(img1, img2, H2to1)

% translation = [H2to1(2,3) H2to1(1,3) 0];
% translation = round(translation);
% imagesize = size(img2) + abs(translation);
save('../results/q6_1.mat','H2to1');

upright = H2to1*[size(img2,2) 1 1]';
upright = [round(upright(1)/upright(3)) round(upright(2)/upright(3))];
downright = H2to1*[size(img2,2) size(img2,1) 1]';
downright = [round(downright(1)/downright(3)) round(downright(2)/downright(3))];
width = max(downright(1),upright(1));
sx=1; sy=1; tx=10; ty=10;
sx = 1024/width;
sy = sx;
height = ceil((downright(2)-upright(2))*sy);

if (upright(2)<0)
    ty = -upright(2)*sy+10;
end

M=[sx 0 tx; 0 sy ty; 0 0 1];
out_size = [height+20 1024+20 3];

warp_im1 = warpH(img1, M, out_size); 
warp_im2 = warpH(img2, M*H2to1, out_size);

% figure
% imshow(warp_im1);
% figure
% imshow(warp_im2);

panoImg=zeros(out_size);

panoImg1= im2double(warp_im1);
mask1 = zeros(size(img1,1), size(img1,2));
mask1(1,:) = 1; mask1(end,:) = 1; mask1(:,1) = 1; mask1(:,end) = 1;
mask1 = bwdist(mask1, 'city');
mask1 = mask1/max(mask1(:));
mask1 = warpH(mask1, M, out_size);


panoImg2= im2double(warp_im2);
mask2 = zeros(size(img2,1), size(img2,2));
mask2(1,:) = 1; mask2(end,:) = 1; mask2(:,1) = 1; mask2(:,end) = 1;
mask2 = bwdist(mask2, 'city');
mask2 = mask2/max(mask2(:));
mask2 = warpH(mask2, M*H2to1, out_size);

for x=1:out_size(2)
    for y=1:out_size(1)
        panoImg(y,x,:)=(panoImg1(y,x,:)*mask1(y,x)+panoImg2(y,x,:)*mask2(y,x)) / (mask1(y,x)+mask2(y,x));
    end
end
% 
% figure
% imshow(panoImg)
end 