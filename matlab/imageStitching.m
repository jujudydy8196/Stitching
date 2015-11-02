function [panoImg] = imageStitching(img1, img2, H2to1)

save('../results/q6_1.mat','H2to1');
% warp_im = warpH(img2, H2to1, imagesize(1:2));

translation = [H2to1(2,3) H2to1(1,3) 0];
translation = round(translation);
imagesize = size(img2) + abs(translation);
warp_im = warpH(img2, H2to1, imagesize);

% imagesize = imagesize(1,1:2);
overlap = size(img1)+size(img2)-imagesize;

% if (overlap(1) > overlap(2))
% 	drop = linspace(1,0,overlap(1));
% else
% 	drop = linspace(1,0,overlap(2));
% end

% drop = [drop; fliplr(drop)];
panoImg=zeros(imagesize);
panoImg1=zeros(imagesize);
panoImg2=zeros(imagesize);
% panoImg1(1:size(img1,1),1:size(img1,2),:) = im2double(img1);

% panoImg2(size(img1,1)-overlap(1)+1:size(img1,1),size(img1,2)-overlap(2)+1:size(img1,2),:) = panoImg2(size(img1,1)-overlap(1)+1:size(img1,1),size(img1,2)-overlap(2)+1:size(img1,2),:).*repmat(mask(1:round(size(mask,1)/2),1:round(size(mask,2)/2)),1,1,3);

% panoImg1(size(img1,1)-overlap(1)+1:size(img1,1),size(img1,2)-overlap(2)+1:size(img1,2),:) = panoImg1(size(img1,1)-overlap(1)+1:size(img1,1),size(img1,2)-overlap(2)+1:size(img1,2),:).*repmat(mask(round(size(mask,1)/2)+1:end,round(size(mask,2)/2)+1:end),1,1,3);


panoImg1(1:size(img1,1),1:size(img1,2),:)=im2double(img1);
mask1 = zeros(size(img1,1), size(img1,2));
mask1(1,:) = 1; mask1(end,:) = 1; mask1(:,1) = 1; mask1(:,end) = 1;
mask1 = bwdist(mask1, 'city');
mask1 = mask1/max(mask1(:));
mask1(imagesize(1),imagesize(2))=0;

panoImg2= im2double(warp_im);
mask2 = zeros(size(img2,1), size(img2,2));
mask2(1,:) = 1; mask2(end,:) = 1; mask2(:,1) = 1; mask2(:,end) = 1;
mask2 = bwdist(mask2, 'city');
mask2 = mask2/max(mask2(:));
mask2 = warpH(mask2, H2to1, imagesize);

for x=1:imagesize(2)
    for y=1:imagesize(1)
        panoImg(y,x,:)=(panoImg1(y,x,:)*mask1(y,x)+panoImg2(y,x,:)*mask2(y,x)) / (mask1(y,x)+mask2(y,x));
    end
end
% panoImg1(1:overlap(1),size(img1,2)-overlap(2)+1:size(img1,2),:)= panoImg1(1:overlap(1),size(img1,2)-overlap(2)+1:size(img1,2),:) .* repmat(drop,[1 1 3]);
% panoImg2(1:overlap(1),size(img1,2)-overlap(2)+1:size(img1,2),:)= panoImg2(1:overlap(1),size(img1,2)-overlap(2)+1:size(img1,2),:) .* repmat(drop(2,:),[overlap(1) 1 3]);
% panoImg=panoImg1+panoImg2;
% panoImg2()

    

% img1+warp_im;
figure
imshow(warp_im);
figure
imshow(panoImg);



end

