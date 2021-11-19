function pc = getCarbonPressure(sv,in)

%Get the index that corresponds to the model time 
idx  = floor(10*(round(sv.t,2) - 700) + 1); 

%Get carbon pressure
pc  = in.carbon_profile.output.trace(idx,1);

end