function out = writeOutput(sv,rates,out)
out.pressures(end+1,1)  = sv.pn;
out.deltas(end+1,1)  = sv.dn;
out.rates(end+1,:) = rates';
out.times(end+1,1) = sv.t;
out.timesteps(end+1,1) = sv.k;
out.negative_flags(end+1,1)  = sv.negative_flag;
end 