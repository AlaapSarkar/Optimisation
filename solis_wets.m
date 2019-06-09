function [x_cb,f_cb,list_x,list_f,count]=solis_wets(func,n,low_l,up_l,max_call,s_max,ae,f_max,ac)
d=up_l-low_l;
x_cb=d*rand(1,n)+low_l; %initial guess
f_cb=func(x_cb);
count=1; %counting number of function calls
r=1;
s=0;
f=0;
b=zeros(1,n);
list_x=zeros(max_call,n);
list_f=zeros(max_call,1);
list_x(1,:)=x_cb;
list_f(1,:)=f_cb;
c=1;
while count<max_call
    x_new=x_cb+b+r*randn(1,n);
    x_new=toro(x_new,up_l,low_l);
    f_new=func(x_new);
    x_new2=2*x_cb-x_new;
    x_new2=toro(x_new2,up_l,low_l);
    f_new2=func(x_new2);
    count=count+1;
    if f_new<f_cb
        b=0.4*(x_new-x_cb)+0.2*b;
        x_cb=x_new;
        f_cb=f_new;
        list_x(c,:)=x_cb;
        list_f(c,:)=f_cb;
        c=c+1;
        s=s+1;
        f=0;
    elseif f_new2<f_cb
        b=b-0.4*(x_new-x_cb);
        x_cb=x_new2;
        f_cb=f_new2;
        list_x(c,:)=x_cb;
        list_f(c,:)=f_cb;
        c=c+1;
        s=s+1;
        f=0;
    else
        s=0;
        f=f+1;
    end
    if s>s_max
        r=ae*r;
    elseif f>f_max
        r=ac*r;
    end
end
list_x=list_x(1:c-1,:);
list_f=list_f(1:c-1,:);
end