

im1=imread('../data/model_chickenbroth.jpg');
im1=im2double(im1);
if size(im1,3)==3
    im1= rgb2gray(im1);
end
rotDegree=[0:10:360];
rotMatch=[];
[locs1, desc1] = briefLite(im1);

% figure
for d=rotDegree
    im2 = imrotate(im1,d);
    [locs2, desc2] = briefLite(im2);

    [matches] = briefMatch(desc1, desc2);
    rotMatch = [ rotMatch length(matches)];
%     subaxis(6,3,d/10, 'Spacing', 0.01, 'Padding', 0.01, 'Margin', 0.01);
%     plot(9,2,d/10)
%     plotMatches(im1, im2, matches, locs1, locs2);
%     title(num2str(d))
    
end

figure
bar(rotDegree,rotMatch);

