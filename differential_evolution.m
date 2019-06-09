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
function [xbest,fbest,count]=differential_evolution(func,n,low_l,up_l,max_call,pop_n,F,CR)
d=up_l-low_l; % range
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
n_print=0;
print_idx=0;
SD_f=sqrt(var(pop_fitness));
while SD_max>0.0001 && count<max_call && SD_f>0.00001
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
        xm=xbest+F*(xr(2,:)-xr(3,:));
        % crossover between the mutation vector and the individual
        x_off=binomial_cross(pop(i,:),xm);
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
    SD_f=sqrt(var(pop_fitness));
    if mod(print_idx,100)==0
        fprintf(repmat('\b',1,n_print));
        msg=sprintf('%d %d',print_idx,fbest);
        fprintf(msg);
        n_print=numel(msg);
    end
    print_idx=print_idx+1;
end
fprintf('\n end\n')
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