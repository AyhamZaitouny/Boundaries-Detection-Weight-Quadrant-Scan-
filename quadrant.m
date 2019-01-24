function qq=quadrant(rr)

%This function is to calculate the density quadrant scan curve from a recurrence matrix rr

[dx,dy]=size(rr);

if dx~=dy,
    disp('matrix not square');
end;

hand=waitbar(0,'quadrant');

for i=1:dx
    pp=rr(1:(i-1),1:(i-1));  %points at the first quadrant
    ff=rr((i+1):dx,(i+1):dx);  %points at the third quadrant
    pf=rr(1:(i-1),(i+1):dx);   %points at the second quadrant
    fp=rr((i+1):dx,1:(i-1));    % points at the fourth quadrant
    qs=(sum(pp(:))+sum(ff(:))) /((i-1)^2+(dx-i)^2);
    qs=qs / (qs + (sum(pf(:))+sum(fp(:)))/((i-1)*(dx-i)*2));
    qq(i)=qs;
    waitbar(i/dx,hand);

end;
close(hand);
