function [pn_new, flag] = advancePressure(sv,in,rates)

%Forward Euler advance:
pn_new = sv.pn + sum(rates)*sv.k;

%Handle negative atmospheres
%{
A negative pressure can occur because nitrate deposition is a
fixed rate, and does not depend on the mixing ratios. All other loss
processes will adjust 
%}

%Set negative flag to 0
flag = 0;

if pn_new <= in.min_pressure
    pn_new = in.min_pressure;
    flag = 1;
end

end