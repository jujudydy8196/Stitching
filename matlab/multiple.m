s = {%'../report/pic/input/P4280010.JPG';...
%      '../report/pic/input/P4280011.JPG';...
% 	 '../report/pic/inputP4280012.JPG';...
% 	 '../report/pic/inputP4280013.JPG';...
	 '../report/pic/input/P4280016.JPG';...
	 '../report/pic/input/P4280015.JPG';...
% 	 '../report/pic/input/P4280014.JPG';...
% 	 '../report/pic/inputP4280017.JPG';...
% 	 '../report/pic/inputP4280018.JPG';...
% 	 '../report/pic/inputP4280019.JPG';...
% 	 '../report/pic/inputP4280020.JPG';...
% 	 '../report/pic/inputP4280021.JPG';...
% 	 '../report/pic/inputP4280022.JPG';...
% 	 '../report/pic/inputP4280023.JPG';...
	};

f_length = (  756.252 + 761.442 +763.042)/3;

% f_length = ( 741.287 + 749.887 + 754.936 + 758.929 + 756.252 + 761.442 +763.042 + 766.304 + 737.705 +745.46 + 745.212 + 745.33 + 730.618 + 731.427  )/14;

for i=1:length(s)
	img{i} = imread(s{i});
    img{i} = im2double(img{i});
	img_c{i} = Cylindrical(img{i},f_length);
    if size(img_c{i},3)==3
        img_gray{i}= rgb2gray(img_c{i});
    else
        img_gray{i}=img_c{i};
    end    
end

[locs1{1}, desc1{1}] = briefLite(img_gray{1});
[locs2{1}, desc2{1}] = briefLite(img_gray{2});
matches{1} = briefMatch(desc1{1}, desc2{1});
bestH{1} = ransacH(matches{1}, locs1{1}, locs2{1}, 1000, 20);
im3 = imageStitching_noClip(img_c{1}, img_c{2}, bestH{1}); 
    
for i=2:length(s)-1
%     im3 = im2double(im3);
    im3_gray = rgb2gray(im3);
    [locs1{i}, desc1{i}] = briefLite(im3_gray);
    [locs2{i}, desc2{i}] = briefLite(img_gray{i+1});
    matches{i} = briefMatch(desc1{i}, desc2{i});
    bestH{i} = ransacH(matches{i}, locs1{i}, locs2{i}, 1000, 20);
    im3 = imageStitching_noClip(im3, img_c{i+1}, bestH{i});  
    
%     im3 = imageStitching_noClip(img_c{i}, img_c{i+1}, bestH{i});
end
% im3 = imageStitching_noClip(img_c{1}, img_c{2}, bestH{1});
% for i=2:length(s)-1
%     im3 = imageStitching_noClip(im3, img_c{i+1}, bestH{i});
% end
    figure
    imshow(im3);
