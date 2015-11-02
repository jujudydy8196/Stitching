function H2to1=computeH(p1,p2)

p1x = p1(:,1);
p1y = p1(:,2);
p2x = p2(:,1);
p2y = p2(:,2);
N = size(p1,1);

threezero = [zeros(N,3)];
ax = [p2x p2y ones(N,1) threezero (-p2x.*p1x) (-p2y.*p1x) -p1x];
ay = [threezero p2x p2y ones(N,1) (-p2x.*p1y) (-p2y.*p1y) -p1y];
a = [ax; ay];  %9x2N
if (N==4)
    [u,s,v] = svd(a'*a);
else
    [u,s,v] = svd(a'*a,'econ');
end
% [val vec] = eig(aT*aT')

%derive the eigen vector corresponding to the smallest eigen value
%svd diagonal matrix singular values sorted just take 9th cols.
% s
% find(diag(s)==min(diag(s)))
h = v(:,end);
h = h/h(9);

H2to1 = reshape(h,3,3)';
end