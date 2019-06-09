function Y=rosenbrock_function(X)
    n=length(X);
    if n>1
        Xi=X(1:n-1);
        Xi1=X(2:n);
        F=100*(Xi1-Xi.^2).^2+(1-Xi).^2;
        Y=sum(F);
    else
        Y=(1-X)^2+100*X^4;
    end
end