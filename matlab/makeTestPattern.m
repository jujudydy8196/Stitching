function [compareX, compareY] = makeTestPattern(patchWidth, nbits)

sigma=patchWidth/5;
mean=0;
x1=sigma.*randn(nbits,1)+mean;
x2=sigma.*randn(nbits,1)+mean;
y1=sigma.*randn(nbits,1)+mean;
y2=sigma.*randn(nbits,1)+mean;

compareX=round((x1+patchWidth/2)*patchWidth+x2+patchWidth/2);
compareY=round((y1+patchWidth/2)*patchWidth+y2+patchWidth/2);

compareX(find(compareX(:)<1))=1;
compareY(find(compareY(:)<1))=1;
compareX(find(compareX(:)>patchWidth^2))=patchWidth^2;
compareY(find(compareY(:)>patchWidth^2))=patchWidth^2;

save('testPattern.mat','compareX','compareY');
end