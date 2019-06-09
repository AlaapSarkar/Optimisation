func=@schwefel;
up_l=500;
low_l=-500;
n=100;
pop_n=10*n;
F=1;
CR=0.9;
const=1;
dom_fr=0.4;
r_factor=0.5;
d=up_l-low_l; % range
r=dom_fr*d;
count=0; % counter for number of function calls
pop=d*rand(pop_n,n)+low_l; % initial population
pop_fitness=zeros(pop_n,1);
xbest=pop(1,:);
fbest=func(xbest);
count=count+1;
for i=1:pop_n % fitness of each individual
	pop_fitness(i)=func(pop(i,:));
    count=count+1;
    if pop_fitness(i)<fbest
        xbest=pop(i,:);
        fbest=pop_fitness(i);
    end
end
SD_pop=sqrt(var(pop));
SD_max=max(SD_pop); % max standard deviation in the input variables
de_count=0;
s_count=0;
while SD_max>0.0001%count<max_call
    future_pop=zeros(pop_n,n); % initialising the next generation
    future_pop_fitness=zeros(pop_n,1); % initialising the fitness of the next generation
    f_i=fbest;
    options=1:pop_n;
    xr=zeros(3,n);
    for j=1:3
        rand_choice=ceil(length(options)*rand);
        xr(j,:)=pop(rand_choice,:);
        options(rand_choice)=[];
    end
    spread=sqrt(max(var([xr;pop(i,:)])))/d;
    p_DE=(const+1)*spread/(const*spread+1);
    p_S=1-p_DE;
    if rand<p_DE
        future_pop=zeros(pop_n,n); % initialising the next generation
        future_pop_fitness=zeros(pop_n,1); % initialising the fitness of the next generation
        for i=1:pop_n
            % creating a mutation vector for each individual
            options=1:pop_n;
            xr=zeros(3,n);
            for j=1:3
                rand_choice=ceil(length(options)*rand);
                xr(j,:)=pop(rand_choice,:);
                options(rand_choice)=[];
            end
            xm=xr(1,:)+F*(xr(2,:)-xr(3,:));
            % crossover between the mutation vector and the individual
            x_off=binomial_cross(pop(i,:),xm,CR);
            x_off=toro(x_off,up_l,low_l);
            fx_off=func(x_off);
            count=count+1;
            % selection between the offspring and the individual
            if fx_off<=pop_fitness(i)
                future_pop(i,:)=x_off;
                future_pop_fitness(i)=fx_off;
                if fx_off<=fbest
                    fbest=fx_off;
                    xbest=x_off;
                end
            else
                future_pop(i,:)=pop(i,:);
                future_pop_fitness(i)=pop_fitness(i);
            end
        end
        % setting the next generation as the current generation
        pop=future_pop;
        pop_fitness=future_pop_fitness;
        SD_pop=sqrt(var(pop));
        SD_max=max(SD_pop);
        de_count=de_count+1;
    else
        %s
        fitness_list=max(pop_fitness)-pop_fitness;
        fl_sum=sum(fitness_list);
        f_rand=rand*fl_sum;
        fsum=0;
        
        for i=1:length(fitness_list)
            fsum=fsum+fitness_list(i);
            if fsum>f_rand
                idx=i;
                break
            end
        end
        x_cb=pop(idx,:);
        f_min=pop_fitness(idx);
        f_i=f_min;
        for i=1:n
            P=x_cb;
            x_i=P(i)-r+r*randn;
            x_i=toro(x_i,up_l,low_l);
            P(i)=x_i;
            f_P=func(P);
            count=count+1;
            if f_P<=f_min
                x_cb=P;
                f_min=f_P;
            else
                P=x_cb;
                x_i=P(i)+r+r*randn;
                x_i=toro(x_i,up_l,low_l);
                P(i)=x_i;
                f_P=func(P);
                count=count+1;
                if f_P<=f_min
                    x_cb=P;
                    f_min=f_P;
                else
                    P=x_cb;
                end
            end
        end
        if f_i==f_min
            r=r*r_factor;
        else
            pop(idx,:)=x_cb;
            pop_fitness(idx)=f_min;
        end
        s_count=s_count+1;
    end
end

%%%%
function x_off=binomial_cross(x1,x2,CR)
n=length(x1);
index=ceil(n*rand);
x_off=zeros(1,n);
for k=1:n
    if rand<=CR||k==index
        x_off(k)=x1(k);
    else
        x_off(k)=x2(k);
    end
end
end