% [0,10]
function Y=alpine(X)
sin_x=sin(X);
Y=sum(X.*sin_x+0.1*X);
end