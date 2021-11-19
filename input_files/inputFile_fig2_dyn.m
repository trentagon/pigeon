%% Constants [no choice permitted]

in.amu = 1.660538782e-27; %kilograms in an amu
in.myr2sec = 31557600e+6; %seconds in 1 million years
in.mars_r = 3389.5e+3; %Mars radius in meters
in.mars_g = 3.71; %Mars surface gravity in meters sec^-2

%Present day composition of Mars atmosphere
%https://nssdc.gsfc.nasa.gov/planetary/factsheet/marsfact.html
%These 5 species make up 99.85% of the atmosphere
in.pres_co2 = 0.951;
in.pres_n2  = 0.0259;
in.pres_ar  = 0.0194;
in.pres_o2  = 0.0016;
in.pres_co  = 0.0006;
%Mixing ratio by volume (standard def) = mixing ratio by mass/molar masses

%% Free parameters

in.file_description = "This is an input file for PIGEON that is configured to figure 2-dynamical of Hu and Thomas 2022.";

%Start and end time
in.t_start   = 700; % [Myr] 700 Myr = 3.8 Ga (time starts at 4.5 Ga)
in.t_end     = 4500; % [Myr] 4500 Myr = 0 Ga = Today

in.pn0  = 245; % Initial pressure of N2[mbar]
%Slightly different value than the figure due to model improvements

in.zt = 0.35; %Distance from homopause to exobase divided by temperature, matters for diffusion

in.euv_pl = 1.3; %Power law index for N2 photochemical loss via euv flux
in.euv_uncertainty = 0; %Uncertainty in the euv flux evolution, [-0.1,0.1]

in.f_photoN = 1.3; %Photochemical multiplier
in.f_sputtering = 1.0; %Sputtering multiplier
in.f_outgassing = 1.5; %Outgassing multiplier

in.d_nit = 50; %Depth of early nitrate deposition [m]

in.carbon_case = 3; % set the carbon evolution [1-5]
%1: 0.25 bar evolution
%2: 0.5 bar evolution
%3: 1.00 bar evolution
%4: 1.80 bar evolution
%5: 0.007 bar held constant
in.carbon_profile = load(['case',num2str(in.carbon_case),'.mat']); %Load in the carbon data

%% Select chronology and load outgassing profile [All species]

% Mantle concentration [by mass]
in.crustX_n2 = 1.9E-6; 

%Isotopic composition of mantle
in.dn_mantle  = 1 + (-.03);   %upper limit = .3, lower limit = -0.03

%Starting delta value
in.dn0  = in.dn_mantle;

chron_str = "hart"; %Which chronology to use? Hartmann 2005 or Ivanov 2001
%"hart" or "ivan"

chron_ivan = in.t_end - 1000*[3.86,3.74,3.65,3.46,1.45,0.387]; %Ivanov 2001
chron_hart = in.t_end - 1000*[3.85,3.57,3.40,3.00,0.880,0.235]; %Hartmann 2005

og_convert = 1000^3 * in.mars_g * 0.01 / (4 * pi * (in.mars_r)^2); %kg -> mbar
%note: og_profile is the crustal production rate in units of km^3/Myr
%inclusion of 1000^3 to convert og_profile to m^3/Myr

crust_density = 2900; %kg/m^3

%Select chronology and corresponding crustal production profile
switch chron_str
    case "hart"
        chron = chron_hart;
        oo = load('og_hart.mat');
        in.og_profile = oo.og_profile;
    case "ivan"
        chron = chron_ivan;
        oo = load('og_ivan.mat');
        in.og_profile = oo.og_profile;
end

in.og_profile(1,:) = in.f_outgassing * in.og_profile(1,:) * og_convert * crust_density;
%This currently gives the mbar/Myr of outgassing of all crustal species
%--> Multiply by a concentration [by mass] to get the outgassing profile
%[mbar/Myr] of a given species

%% Photochemical Loss

in.photodiss_case = 3; %Photodissociation of N2 cases to choose from [1,4]
% See figure S1 in Hu and Thomas 2022

photodissociation_flux_total = 1.4438e+23;
switch in.photodiss_case
    case 1
        photoPD_frac = 1;
        flux_pct = 0;
    case 2
        photoPD_frac = 0.15;
        flux_pct = 0.01;
    case 3
        
        % STANDARD CASE
        photoPD_frac = 0.29;
        flux_pct = 0.41;
        
    case 4
        photoPD_frac = 0.29;
        flux_pct = 1;
end

%Escaping nitrogen particles per second
in.photo_fluxPD_n = photodissociation_flux_total * flux_pct; %Photodissociation
in.photo_fluxDR_n = 2.8874e+23; %Dissociative Recombination
in.photo_fluxOP_n = 2.5411e+23; %Other processes

%Fractionation factors of nitrogen loss via photochemical reactions
in.alph_photoPD_n = photoPD_frac; %Photodissociation
in.alph_photoDR_n = 0.58; %Dissociative Recombination
in.alph_photoOP_n = 1; %Other processes

%% Ion Loss

in.f_ion = 1; %Ion multiplier
in.cphi0 = 8.66E+22; %Present day ion escape flux of CO2+ [particles/sec]
in.ion_ratio = 0.1;  %Ratio of N2+ to CO2+ at 160km, measured by MAVEN, Wither+15, Bougher+15

%% Nitrate Deposition

in.alph_nitrate = 1.01; %Fractionation factor of nitrate deposition

nit_massratio = 14/62; %Mass ratio in crust: N/NO3-
nit_conv = in.mars_g * 0.01; %kg(N)/ m^2 Myr -> mbar/Myr

%Amazonian values
nit_am_rho  = 2000; % [kg/m3] crust density
nit_am_dep  = 10; % [m] depth of crustal deposition
nit_am_conc = 180E-6; % [wt%] concentration of nitrate in crust

%Values in the Hesperian and Noachian (same units and meaning as Amazonian)
nit_nh_rho  = 3000;
nit_nh_dep  = in.d_nit; %d_nit: free parameter
nit_nh_conc = 300E-6;

early_total_n = nit_conv*nit_massratio*nit_nh_rho*nit_nh_dep*nit_nh_conc;
late_total_n = nit_conv*nit_massratio*nit_am_rho*nit_am_dep*nit_am_conc;

early_rate_n = early_total_n/abs(in.t_start - chron(4));%Convert total amount to rate
late_rate_n = late_total_n/abs(in.t_end - chron(4));

%Smooth the step function into a sigmoid
nit_x = in.t_start:0.01:in.t_end;
in.nitrate_profile(1,:) = early_rate_n + (sigmf(nit_x,[0.025, chron(4)])*(late_rate_n - early_rate_n));
in.nitrate_profile(2,:) = nit_x;

%% Technical specifications

%Timestepping
in.ptol_fast = 0.15; %Maximum percent change to pressure via fastest source or sink
in.ptol_total = 0.0005; %Maximum percent change to pressure via all processes combined
in.k_max = 1; %Maximum allowable timestep
in.k_min = 0.1; %Minimum allowable timestep

%Negative atmosphere handling
in.min_pressure = 0.0001; %[mbar] Set the pressure to this value if it is going to be negative

