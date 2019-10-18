.mat file:
cec2014.mat: ranges for all the functions implemented (needs to be loaded before running files).
results.mat: contains 3 structures which are the final data comparing S (results2) DE(results1) and DES(resaults)

.m files:

1. ackley.m: ackley function
2. alpine.m: alpine function
3. de_jong.m: de jong (or sphere) function
4. DE_S.m: as the points come closer the probability of S algorithm increases (needs to be refined)
5. DE_S2.m: DE or S is randomly applied on an individual from the population
6. de_test.m: used to test various parameters of differential_evolution_Smut.m (mainly scaling factor F which can be a single value or an array)
7. DES.m: S algorithm applied on the best solutions and mutation and crossover applied to others.
8. differential_evolution.m: implementation of differential evolution.
9. differential_evolution_Smut.m: differential evolution with S as a factor in mutation vector.
10. evolutionary_programming.m: implementation of evolutionry programming.
11. final_test.m: file used to generate data for the different algorithms
12. happy_cat.m: happy cat function
13. HGBat.m: HGBat function
14. katsuura.m: katsuura function
15. memetic.m: file comparing differential_evolution.m, s_algorithm.m and DE_S2.m
16. michalewicz.m: michalewicz function
17. rosenbrock_function.m: rosenbrock function
18. s_algorithm.m: implementation of S algorithm
19. s_algorithm_nm.m: non monotonic S algorithm
20. schwefel.m: schwefel function
21. simulated_annealing.m: implementation of simulated annealing algorithm
22. solis_wets.m: implementation of solis wets algorithm
23. stochastic_s_algorithm.m: S algorithm with randomness
24. test.m: used to test s algorithms
25. toro.m: toroidal correction

Check out the wiki for the documentation.
