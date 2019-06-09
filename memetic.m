func=@schwefel;
low_l=-500;
up_l=500;
n_list=50;
m=length(n_list);
result=cell(m+1,4);
result{1,1}='Dimensions';
result{1,2}='DE';
result{1,3}='Stochastic S';
result{1,4}='DES';
pm=char(177);
for j=2:m+1
n=n_list(j-1);
listx_s=zeros(10,n);
listx_de=zeros(10,n);
listx_des=zeros(10,n);
listf_s=zeros(10,1);
listf_de=zeros(10,1);             
listf_des=zeros(10,1);
    for i=1:10
        tic
        [x_cb,f_min,list_x,list_f,num,list_r]=s_algorithm(func,n,low_l,up_l,n*5000,0.4,0.5);
        toc
        listx_s(i,:)=x_cb;
        listf_s(i)=f_min;
        tic
        [xbest1,fbest1,count1]=differential_evolution(func,n,low_l,up_l,n*5000,50,1,0.9);
        toc
        listx_de(i,:)=xbest1;
        listf_de(i)=fbest1;
        % tic
        % [x_cb,f_min,list_x,list_f,list_r,num]=s_algorithm_nm(func,n,low_l,up_l,n*5000,0.4,0.5,100);
        % toc
        tic
        [xbest2,fbest2,count2]=DE_S2(func,n,low_l,up_l,n*5000,50,1,0.9);
        toc
        % the more spread out the higher probability of DE, choose k points
        % randomly check the spread
        listx_des(i,:)=xbest2;
        listf_des(i)=fbest2;
    end
avgs=mean(listf_s);
avgde=mean(listf_de);
avgdes=mean(listf_des);
sds=sqrt(var(listf_s));
sdde=sqrt(var(listf_de));
sddes=sqrt(var(listf_des));
result{j,1}=n;
result{j,2}=sprintf('%.2d %s %.2d',avgde,pm,sdde);
result{j,3}=sprintf('%.2d %s %.2d',avgs,pm,sds);
result{j,4}=sprintf('%.2d %s %.2d',avgdes,pm,sddes);
end
disp(result)