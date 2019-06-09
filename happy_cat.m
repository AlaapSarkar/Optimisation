% [-2,2]
function Y=happy_cat(X)
n=length(X);
sum_sqr=sum(X.^2);
Y=(abs(sum_sqr-n))^(1/4)+(0.5*sum_sqr+sum(X))/n+0.5;
end