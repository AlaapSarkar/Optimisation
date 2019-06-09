f='HGBat';
func=str2func(f);
n=50;
low_l=-2;
up_l=2;
F=0.5;
n_runs=10;
res_row=length(F);
res_col=n_runs;
results=zeros(res_row*res_col,3);
for j=1:res_row
    for i=1:n_runs
        Fi=F(j);
        [xbest,fbest,count]=differential_evolution_Smut(func,n,low_l,up_l,n*5000,50,Fi,0.9,3);
        results((j-1)*n_runs+i,1)=F(j);
        results((j-1)*n_runs+i,2)=fbest;
        results((j-1)*n_runs+i,3)=count;
    end
end
f1=figure;
scatter(results(:,1),results(:,2))
title(f)
xlabel('scale factor')
ylabel('minimum found')
f2=figure;
scatter(results(:,1),results(:,3))
title(f)
xlabel('scale factor')
ylabel('function calls')