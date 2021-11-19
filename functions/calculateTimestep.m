function k = calculateTimestep(sv,in,rates)
%{
This function calculates the maximum allowable timestep for the model at a 
given time. The principle behind this calculation is that at each timestep,
we require that the n2 pressure only changes by 
the percentage 'in.ptol_total'. We're using Forward Euler, so this can 
be done exactly.
%}

%Find the fastest rate
fastest_n = max(abs(rates));

%Find max timestep based on change threshold and fastest rate
k_fastest = in.ptol_fast*sv.pn/fastest_n;

%Find the total rate for each species
total_n = abs(sum(rates));

%Find max timestep based on change threshold and total rate
k_total = in.ptol_total*sv.pn/total_n;

%Take minimum of the two possible timesteps and the maximum allowable step
k = min([k_fastest, k_total, in.k_max]);

%Take maximum of k and the minimum allowable step
k = max([k, in.k_min]);

end