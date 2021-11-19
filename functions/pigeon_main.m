function out = pigeon_main(in)

tStart = tic; %Start clock

%% Initialize Data Structures

%----Core structs----
%"in": inputs, contains science inputs and a few technical specifications
%"sv": state vector, contains primary variables that update during each loop
%"rates": rates, contains sources and sinks for each species
%"out": output, contains saved values for outputting

%Initialize state vector
sv.pn = in.pn0; %Initial pressure of nitrogen
sv.dn = in.dn0; %Initial delta of nitrogen
sv.t  = in.t_start; %time
%sv.k = timestep; calculated in first loop
sv.negative_flag = 0; %flag that checks for negative values
sv.pc = getCarbonPressure(sv,in); %Initial pressure of carbon

%Initialize output
out.title = "This is the output data from a run of pigeon_main.m";
out.runDate = datestr(now, 'mm/dd/yy-HH:MM:SS');

%Create storage
out.pressures = []; % partial pressure of N2
out.deltas = []; % isotopic composition of N2
out.times = []; % Time values
out.timesteps = []; % Timestep sizes
out.negative_flags = []; % Negative atmospheres 
out.rates  = []; % Rates

%% Run the model loop

tLoop = tic; %Record the loop time
running = 1;
while running
        
    %%%%%%%%%%%%%%%%%%%%%% RATE CALCULATIONS %%%%%%%%%%%%%%%%%%%%%%
    %Calculate rate of impact of the sources and sinks
    rates = calculateRates(sv, in); 

    %%%%%%%%%%%%%%%%%%%%%% TIMESTEP CALCULATIONS %%%%%%%%%%%%%%%%%%%%%%
    %Determine the maximum allowable timestep
    sv.k = calculateTimestep(sv,in,rates);
    
    %%%%%%%%%%%%%%%%%%%%%% WRITE TO OUTPUT STRUCT %%%%%%%%%%%%%%%%%%%%%%
    %NOTE: This function is kind of expensive
    out = writeOutput(sv,rates,out);

    %%%%%%%%%%%%%%%%%%%%%% ADVANCE THE STATE VECTOR %%%%%%%%%%%%%%%%%%%%%%
    %Advance the presssure and delta values according to rates and tstep
    [new_pn, sv.negative_flag] = advancePressure(sv,in,rates);
    new_dn = advanceDelta(sv,in,rates);
    
    sv.pn = new_pn;
    sv.dn = new_dn;
    sv.pc = getCarbonPressure(sv,in);
    sv.t  = sv.t + sv.k;
        
    %%%%%%%%%%%%%%%%%%%%%% CHECK IF RUN IS DONE %%%%%%%%%%%%%%%%%%%%%%
    running = checkHalt(sv,in);
    
end

%% Process model output
out.rates_labels = ["Sputtering";"Outgassing";"Photochemical (Photodissociation)";"Photochemical (Dissociative Recombination)";"Photochemical (Other Processes)";"Ion";"Nitrate Deposition"];
out.units.pressure = "mbar";
out.units.delta = "unitless [mars atmosphere isotope ratio/standard isotope ratio]";
out.units.rates = "mbar per Myr";
out.units.times = "Myr [million years]";
out.units.what_is_k = "k is the timestep. same units as time, friend.";
out.inputs = in;
out.runtime_total = toc(tStart); %total runtime
out.runtime_loop  = toc(tLoop); %runtime inside the main loop
% out.runtime_total = [num2str(runtime_total), ' seconds'];
% out.runtime_loop = [num2str(runtime_loop), ' seconds'];

%Delta values in per mil
out.deltas_pm = (out.deltas - 1)*1000;
out.units.deltas_pm = "per mil";

%Did the run ever go negative for any species?
out.any_negative = any(out.negative_flags);
if out.any_negative
    fprintf("Warning: atmosphere went negative during model run");
end

%Convert Myr to Ga
out.times_Ga.t = (in.t_end - out.times)/1000;
out.times_Ga.k = out.timesteps/1000;
out.times_Ga.units = "Ga [billion years ago]";

end


