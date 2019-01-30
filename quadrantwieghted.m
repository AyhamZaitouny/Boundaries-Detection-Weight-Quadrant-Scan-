function qq=quadrantwieghted(rr)

%This function is to calculate the weighted quadrand scan from a recurrence matrix rr

[dx,dy]=size(rr);

if dx~=dy,
    disp('matrix not square');
end;

hand=waitbar(0,'quadrant');
qq(1)=0.5;
qq(dx)=0.5;
for i=2:dx-1
    wieghtp=0.5*(1-tanh(((1:i-1)-200)/50));  %the 200 and 50 are parameters and should be changed according to your application
    wieghtp=wieghtp(end:-1:1);
    wieghtf=0.5*(1-tanh(((1:dx-i)-200)/50)); %the 200 and 50 are parameters and should be changed according to your application
    wieghtpp=wieghtp'*wieghtp;
    wieghtpp=wieghtpp./wieghtpp(end,end);
    wieghtff=wieghtf'*wieghtf;
    wieghtff=wieghtff./wieghtff(1,1);
    wieghtpf=wieghtp'*wieghtf;
    wieghtpf=wieghtpf./wieghtpf(end,1);
    wieghtfp=wieghtf'*wieghtp;
    wieghtfp=wieghtfp./wieghtfp(1,end);
    pp=rr(1:(i-1),1:(i-1)).*wieghtpp;
    ff=rr((i+1):dx,(i+1):dx).*wieghtff;
    pf=rr(1:(i-1),(i+1):dx).*wieghtpf;
    fp=rr((i+1):dx,1:(i-1)).*wieghtfp;
    qs=sum(pp(:))+sum(ff(:));
    qs=qs / (qs + (sum(pf(:))+sum(fp(:))));
    qq(i)=qs;
    waitbar(i/dx,hand);

end;
close(hand);
