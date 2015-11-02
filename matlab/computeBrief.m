function [locs,desc] = computeBrief(im, locs, levels, compareX, compareY)

height= size(im,1);
width = size(im,2);
newlocs=[];
desc=[];
GaussianPyramid = createGaussianPyramid(im, 1, sqrt(2),levels);
compareXx = ceil(compareX/9)-5;
compareXy = mod(compareX-1,9)+1-5;
compareYx = ceil(compareY/9)-5;
compareYy = mod(compareY-1,9)+1-5;

for i=1:length(locs)
    if( locs(i,1)>4 & locs(i,1)<width-4+1 & locs(i,2)>4 & locs(i,2)<height-4+1)
        p1x=locs(i,1)+compareXx;
        p1y=locs(i,2)+compareXy;
        p2x=locs(i,1)+compareYx;
        p2y=locs(i,2)+compareYy;
        temp=[];
        lev_idx = find(levels==locs(i,3));
        for j=1:length(compareX)
            if (GaussianPyramid(p1y(j),p1x(j),lev_idx)<GaussianPyramid(p2y(j),p2x(j),lev_idx))
                temp = [temp 1];
            else
                temp = [temp 0];
            end
        end
        desc = [desc; temp];
        newlocs=[newlocs; locs(i,:)];
    end
end
    locs = newlocs;
end
