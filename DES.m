% Differential evolution function
% Inputs:
%   func: the problem to be optimised
%   n: the number of input variables
%   low_l: lower limit of the domain
%   up_l: upper limit of the domain
%   max_call: maximum no. of times the function should be called. 5000*n
%   pop_n: number of particles. 10*n (?)
%   F: mutation factor [0.5,1]
%   CR: crossover probability [0.8,1]
% Outputs:
%   fbest: minimum found
%   xbest: location of the minimum
%   count: number of times the function was called
function [xbest,fbest,count,pop,pop_fitness]=DES(func,n,low_l,up_l,max_call,pop_n,F,CR,dom_fr,r_factor)
d=up_l-low_l; % range
count=0; % counter for number of function calls
pop=d*rand(pop_n,n)+low_l; % initial population
pop_fitness=zeros(pop_n,1);
xbest=pop(1,:);
fbest=func(xbest);
count=count+1;
r=dom_fr*d;
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
while count<max_call
    
    future_pop=zeros(pop_n,n); % initialising the next generation
    future_pop_fitness=zeros(pop_n,1); % initialising the fitness of the next generation
    minfit=fbest;
    minsol=xbest;
    for i=1:pop_n
        if pop_fitness(i)~=minfit
            % creating a mutation vector for each individual
            options=1:pop_n;
            xr=zeros(3,n);
            for j=1:3
                rand_choice=ceil(length(options)*rand);
                xr(j,:)=pop(rand_choice,:);
                options(rand_choice)=[];
            end
            xm=minsol+F*(xr(1,:)-xr(2,:));
            % crossover between the mutation vector and the individual
            x_off=binomial_cross(pop(i,:),xm);
            x_off=toro(x_off,up_l,low_l);
            fx_off=func(x_off);
            count=count+1;

            future_pop(i,:)=x_off;
            future_pop_fitness(i)=fx_off;
        else
            f_j=pop_fitness(i);
            f_min=f_j;
            x_cb=pop(i,:);
            for j=1:n
                P=x_cb;
                x_j=P(j)-r;
                x_j=toro(x_j,up_l,low_l);
                P(j)=x_j;
                f_P=func(P);
                count=count+1;
                if f_P<=f_min
                    x_cb=P;
                    f_min=f_P;
                else
                    P=x_cb;
                    x_j=P(j)+r*r_factor;
                    x_j=toro(x_j,up_l,low_l);
                    P(j)=x_j;
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
            future_pop(i,:)=x_cb;
            future_pop_fitness(i)=f_min;
        end
        if future_pop_fitness(i)>pop_fitness(i)
            future_pop_fitness(i)=pop_fitness(i);
            future_pop(i,:)=pop(i,:);
        else
            if future_pop_fitness(i)<fbest
                fbest=future_pop_fitness(i);
                xbest=future_pop(i,:);
            end
        end
    end
    % setting the next generation as the current generation
    pop=future_pop;
    pop_fitness=future_pop_fitness;
    SD_pop=sqrt(var(pop));
    SD_max=max(SD_pop);
    if minsol==xbest
        r=SD_max;
    end
end
% Binomial crossover function
function x_off=binomial_cross(x1,x2)
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
end