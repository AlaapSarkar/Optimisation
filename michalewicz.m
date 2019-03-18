% f_min=-9.66 (m=10) at x=? domain of x_i: [0,pi]
function y=michalewicz(X)
n=length(X);
m=10;
sum=0;
for i=1:n
    x_i=X(i);
    sum=sum+sin(x_i)*sin(i*x_i^2/pi)^(2*m); 
end
y=-sum;