% f_min=0 at x=(0,...,0) domain of x_i: [-5.12,5.12]
function f=de_jong(X)
n=length(X);
sum=0;
for i=1:n
    x_i=X(i);
    sum=sum+(x_i)^2;
end
f=sum;
end