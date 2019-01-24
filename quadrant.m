function qq=quadrant(rr)

[dx,dy]=size(rr);

if dx~=dy,
    disp('matrix not square');
end;

hand=waitbar(0,'quadrant');

for i=1:dx
    pp=rr(1:(i-1),1:(i-1));
    ff=rr((i+1):dx,(i+1):dx);
    pf=rr(1:(i-1),(i+1):dx);
    fp=rr((i+1):dx,1:(i-1));
    qs=(sum(pp(:))+sum(ff(:))) /((i-1)^2+(dx-i)^2);
    qs=qs / (qs + (sum(pf(:))+sum(fp(:)))/((i-1)*(dx-i)*2));
    qq(i)=qs;
    waitbar(i/dx,hand);

end;
close(hand);