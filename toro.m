%toroidal correction
function x_fix=toro(x,ul,ll)
n=length(x);
x_fix=zeros(1,n);
for i=1:n
    di=(x(i)-ll)/(ul-ll);
    if di>1
        di_cor=di-fix(di);
    elseif di<0
        di_cor=1-abs(di-fix(di));
    else
        di_cor=di;
    end
    x_fix(1,i)=di_cor*(ul-ll)+ll;
end
end