%[0,100]
function Y=katsuura(X)
n=length(X);
in_prod=1;
for i=1:n
    in_sum=0;
    for j=1:32
        insum_j=abs(2^j*X(i)-round(2^j*X(i)))/(2^j);
        in_sum=in_sum+insum_j;
    end
    inprod_i=1+i*in_sum;
    in_prod=in_prod*inprod_i;
end
Y=10*in_prod^(10/(n^12))/(n^2)-10/n^2;
end