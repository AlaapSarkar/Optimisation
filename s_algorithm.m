% x_cb is the best solution found
% f_min is the minimum value found
% list_x is the list of successively better solutions
% list_f is the value of the function at corresponding values of list_x
% func is the problem to be optimised
% n is the number of design variables
% max_call is the budget condition
% dom_fr is the initial search radius as a fraction of the domain length
% r_factor is the reduction factor of search radius
% up_l is the upper limit of the domain
% low_l is the lower limit of the domain
% && r>0.0001 in line 22 limits the accuracy to increase the speed of the algorithm
function [x_cb,f_min,list_x,list_f]=s_algorithm(func,n,up_l,low_l,max_call,dom_fr,r_factor)
d=up_l-low_l;
x_cb=d*rand(1,n)+low_l;
r=dom_fr*d;
f_min=func(x_cb);
count=0;
list_x=zeros(max_call,n);
list_f=zeros(max_call,1);
c=1;
while count<max_call && r>0.0001
    f_i=f_min;
    for i=1:n
        P=x_cb;
        x_i=P(i)-r;
        x_i=toro(x_i,up_l,low_l);
        P(i)=x_i;
        f_P=func(P);
        count=count+1;
        if f_P<=f_min
            x_cb=P;
            f_min=f_P;
            list_x(c,:)=x_cb;
            list_f(c,:)=f_min;
            c=c+1;
        else
            P=x_cb;
            x_i=P(i)+r*r_factor;
            x_i=toro(x_i,up_l,low_l);
            P(i)=x_i;
            f_P=func(P);
            count=count+1;
            if f_P<=f_min
                x_cb=P;
                f_min=f_P;
                list_x(c,:)=x_cb;
                list_f(c,:)=f_min;
                c=c+1;
            else
                P=x_cb;
            end
        end
    end
    if f_i==f_min
        r=r*r_factor;
    end
end
list_x=list_x(1:c-1,:);
list_f=list_f(1:c-1,:);
plot(list_f)
save('listx.mat','list_x')
save('listf.mat','list_f')
end
