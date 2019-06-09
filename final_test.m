funcs={'ackley','alpine','de_jong','michalewicz','rastrigin','rosenbrock_function','schwefel','katsuura','happy_cat','HGBat'};
n_list=[30,50,100];
pm=char(177);
n_runs=20;

for i=1:length(funcs)
    func=str2func(funcs{i});
    low_l=cec2014.(funcs{i})(1);
    up_l=cec2014.(funcs{i})(2);
    for j=1:length(n_list)
        n=n_list(j);
        ni=sprintf('n%d',n);
        t_list=zeros(1,n_runs);
        count_list=zeros(1,n_runs);
        fbest_list=zeros(1,n_runs);
        for k=1:n_runs
            tic
            % change the function here
            [xbest,fbest,count]=differential_evolution(func,n,low_l,up_l,n*10000,50,0.5,0.9);
            toc
            t=toc;
            t_list(k)=toc;
            count_list(k)=count;
            fbest_list(k)=fbest;
        end
        f_av=mean(fbest_list);
        f_sd=sqrt(var(fbest_list));
        f_r=sprintf('%d %s %d',f_av,pm,f_sd);
        t_av=mean(t_list);
        t_sd=sqrt(var(t_list));
        t_r=sprintf('%d %s %d',t_av,pm,t_sd);
        c_av=mean(count_list);
        c_sd=sqrt(var(count_list));
        c_r=sprintf('%d %s %d',c_av,pm,c_sd);
        %all data stored in the results1 structure
        results1.(funcs{i}).(ni).fbest=f_r;
        results1.(funcs{i}).(ni).t=t_r;
        results1.(funcs{i}).(ni).func_call=c_r;
        results1.(funcs{i}).(ni).pop=50;
    end
end
% writetable(struct2table(results), 'results.xls')