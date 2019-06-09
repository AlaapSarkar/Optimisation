function [best_individual,best_fitness,list_f]=evolutionary_programming(func,n,low_l,up_l,max_call,pop_n,q,a)
d=up_l-low_l;
individuals=d*rand(pop_n,n)+low_l;
meta_EP=rand(pop_n,n);
list_f=zeros(max_call,1);
fitness=zeros(pop_n,1);
for i=1:pop_n
	fitness(i)=func(individuals(i,:));
end
list_f(1:pop_n)=fitness;
call=pop_n;
c=0;
while call<max_call
	% selection
	% 1 parent 1 offspring so no selection needed

	% recombination
	new_meta_EP=zeros(pop_n,n);
	new_individuals=zeros(pop_n,n);
	new_fitness=zeros(pop_n,1);
    for i=1:pop_n
		for j=1:n
			new_meta_EP(i,j)=meta_EP(i,j)*(1+a*randn);
			new_individuals(i,j)=individuals(i,j)+new_meta_EP(i,j)*randn;
		end
		new_fitness(i)=func(new_individuals(i,:));
		call=call+1;
    end
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 	% survivor selection (deterministic,elitist)
% 	total_pop=[individuals,fitness;new_individuals,new_fitness];
% 	total_pop=sortrows(total_pop,n+1);
% 	individuals=total_pop(1:m,1:n);
% 	fitness=total_pop(1:m,n+1);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% survivor selection 2 (stochastic,elitist)
	%round robin
	total_pop=[individuals,fitness;new_individuals,new_fitness];
	wins=zeros(2*pop_n,1);
    for i=1:2*pop_n
		options=1:2*pop_n;
		options(i)=[];
        for j=1:q
			random_choice=ceil((2*pop_n-j)*rand);
			idx=options(random_choice);
			if total_pop(i,n+1)<total_pop(idx,n+1)
				wins(i)=wins(i)+1;
			end
			options(random_choice)=[];
        end
    end
	total_pop=[total_pop,wins];
	total_pop=sortrows(total_pop,n+2,'descend');
	individuals=total_pop(1:pop_n,1:n);
	fitness=total_pop(1:pop_n,n+1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    c=c+1;
    list_f(c*pop_n+1:(c+1)*pop_n)=fitness;
end
best_individual=individuals(1,:);
best_fitness=fitness(1);
end