function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)

% function [bestH,maxinliners] = ransacH(matches, locs1, locs2, nIter, tol,im1,im2)

% all = length(matches);
match1=locs1(matches(:,1),1:2);
match2=locs2(matches(:,2),1:2);
maxinliners = 0;
maxinlineridx =[];
bestH=[];
% match1homo = [match1'; ones(1,length(matches))];
match2homo = [match2'; ones(1,length(matches))];

for i=1:nIter
    idx = randperm(length(matches),4);
    tempH = computeH(match1(idx,:),match2(idx,:));
%     match2trans = tempH*match1homo;
    match1trans = tempH*match2homo;

    match1trans = [match1trans(1,:)./match1trans(3,:); match1trans(2,:)./match1trans(3,:)];

    
%     match2trans = [match2trans(1,:)./match2trans(3,:); match2trans(2,:)./match2trans(3,:)];
    dis = sqrt( sum((match1trans-match1').^2,1));
    inlineridx = find(dis<=tol);
    inlinernum = length(inlineridx);

    if (inlinernum > maxinliners)
        maxinlineridx = inlineridx;
        maxinliners = inlinernum;
        bestH = tempH;
    end
end
% figure
% plotMatches(im1, im2, matches(maxinlineridx,:), locs1, locs2);
end

