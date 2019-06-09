% [-2,2]
function Y=HGBat(X)
n=length(X);
sum_sqr=sum(X.^2);
sum_n=sum(X);
Y=sqrt(abs(sum_sqr^2-sum_n^2))+(0.5*sum_sqr+sum_n)/n+0.5;
end