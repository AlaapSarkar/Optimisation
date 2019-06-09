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

f=input('Enter the problem: ','s');
n=input('Enter the number of dimensions: ');
func=str2func(f);
low_l=input('Enter the lower limit: ');
up_l=input('Enter the upper limit: ');
limit=input('Enter range of radius reduction factor (can be a single value, should be greater than 0 and less than 1): ');
iter=input('Enter the number of iterations for each set of parameters: ');
dom_fr=0.4;
probfolder=sprintf('%s',f);
subfolder=sprintf('D%d',n);
folderpath=fullfile('testdata',probfolder,subfolder);
if ~exist(folderpath,'dir')
    mkdir(folderpath)
end
f1=figure;
title('minimum found vs radius reduction factor')
f2=figure;
title('number of while loops to convergence vs radius reduction factor')
lr=length(limit);
list=zeros(lr*iter,3);
m=0;
for limit=limit
    max_call=n*5000;
    rfolder=sprintf('r%d',limit);
    fpath = fullfile(folderpath,rfolder);
    if ~exist(fpath,'dir')
        mkdir(fpath)
    end
    xbest=zeros(iter,n);
    fbest=zeros(iter,1);
    for i=1:iter
        [x_cb,f_min,list_x,list_f,num,list_r]=stochastic_s_algorithm(func,n,low_l,up_l,max_call,dom_fr,0.5);
        file=sprintf('test%d.mat',i);
        path=fullfile(fpath,file);
        save(path,'list_x','list_f');
        disp([limit i])
        list(iter*m+i,1)=limit;
        list(iter*m+i,2)=f_min;
        list(iter*m+i,3)=num;
        xbest(i,:)=x_cb;
        fbest(i,:)=f_min;
    end
    bestfile=sprintf('best.mat');
    bestpath=fullfile(fpath,bestfile);
    save(bestpath,'xbest','fbest');
    m=m+1;
end
figure(1)
hold on
s1=scatter(list(:,1),list(:,2));
title('minimum found vs radius reduction factor')
hold off
figure(2)
hold on
s2=scatter(list(:,1),list(:,3));
title('number of while loops to convergence vs radius reduction factor')
hold off