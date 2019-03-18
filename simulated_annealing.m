function [x_cb,f_cb,list_x,list_f,count]=simulated_annealing(func,n,up_l,low_l,max_call,T,a,Tmin)
d=up_l-low_l;
x_cb=d*rand(1,n)+low_l;
count=0;
f_cb=func(x_cb);
list_x=[];
list_f=[];
while count<max_call && T>Tmin
    x_r=d*rand(1,n)+low_l;
    x_new=x_cb+x_r;
    x_new=toro(x_new,up_l,low_l);
    f_new=func(x_new);
    count=count+1;
    if rand<exp((f_cb-f_new)/T)
        x_cb=x_new;
        f_cb=f_new;
        list_x=[list_x;x_cb];
        list_f=[list_f;f_cb];
    end
    T=a*T;
end
plot(list_f)
end