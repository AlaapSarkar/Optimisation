% f_min=0 at x=(420.9687,...,420.9687) domain of x_i: [-500,500]
function y=schwefel(X)
n=length(X);
sum=0;
for i=1:n
	x_i=X(i);
	sum=sum+x_i*sin(sqrt(abs(x_i)));
end
y=418.9829*n-sum;
end