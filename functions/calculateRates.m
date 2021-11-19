function n_rates = calculateRates(sv,in)
%% Calculate the rates of the sources and sinks for all 3 species
%{ 
Inputs: statevector, inputs
Outputs: 1 vector containing the rates of change due to sources
and sinks [mbar/myr]
%}

%% Establish frequently used variables

%Pressures
pc = sv.pc; 
pn = sv.pn;
par = 0.26; %pAr held constant at modern day, 0.26 mbar

%Mixing Ratios
mrc = (pc/44)/((pn/28)+(pc/44)+(par/36));
mrn = (pn/28)/((pn/28)+(pc/44)+(par/36));
mrar = (par/36)/((pn/28)+(pc/44)+(par/36));

%Conversion: particles per second --> mbar/myr
n2_conv  = 28*(in.myr2sec*in.amu*in.mars_g*0.01)/(4 * pi * in.mars_r^2); %this is N2!! not N
% ^^^ note the 0.01 is there to go from pascal to mbar

%Get the index in outgassing and deposition profiles that corresponds to the model time 
idx  = floor(100*(round(sv.t,2) - 700) + 1); 

%% Sputtering

euv_flux = power(sv.t/4500,-1.23 + in.euv_uncertainty); %Evolution of the EUV flux
sput_co2_pps = exp(-0.462*power(log(euv_flux),2)+5.0866*log(euv_flux)+53.49); %sputtering of CO2 in particles per second

%Dilution factor: 
dilute = 1 + (mrn/mrc)*exp(.446*16*in.zt) + (mrar/mrc)*exp(.446*8*in.zt) + (in.pres_o2/in.pres_co2)*exp(.446*12*in.zt) + (in.pres_co/in.pres_co2)*exp(.446*16*in.zt);

%Scaling factors
sp_yield_n  = 2.4; %Jakosky 1994: escaping N particles per sputtering reaction of N2
sp_yield_c  = .7; %Jakosky 1994: escaping C particles per sputtering reaction of CO2
sp_diff_n2_co2 = exp(.446*16*in.zt); %diffusion of N2 and CO2

%Flux calculation
sput_n = -in.f_sputtering*(sp_yield_n/sp_yield_c)*(pn*44/(pc*28))*sp_diff_n2_co2*0.5*n2_conv*sput_co2_pps*(1/dilute); %[mbar/myr] 
%^^^ note the 0.5 is there because "n2_conv" uses M = 28 amu, but the
%nitrogen yield uses particles of N, which have M = 14 amu


%% Outgassing

%Multiply outgassing rate by concentration
outgas_n  = in.og_profile(1,idx)*in.crustX_n2;

%% Photochemical Loss

photoPD_n = -in.f_photoN*(euv_flux^in.euv_pl)*0.5*n2_conv*in.photo_fluxPD_n*mrn/in.pres_n2;
photoDR_n = -in.f_photoN*(euv_flux^in.euv_pl)*0.5*n2_conv*in.photo_fluxDR_n*mrn/in.pres_n2;
photoOP_n = -in.f_photoN*(euv_flux^in.euv_pl)*0.5*n2_conv*in.photo_fluxOP_n*mrn/in.pres_n2;
%^^^ note the 0.5 is there because "n2_conv" uses M = 28 amu

%% Ion Loss [CN]

ionEUV_flux = power(sv.t/4500,-3.51 + 0);
ion_n = -in.f_ion*in.cphi0*ionEUV_flux*0.5*n2_conv*in.ion_ratio*mrn/in.pres_n2;
%^^^ note the 0.5 is there because "n2_conv" uses M = 28 amu

%% Carbonate and Nitrate Deposition [CN]

dep_n = -in.nitrate_profile(1,idx);

%% Format the function output

n_rates = [sput_n; outgas_n; photoPD_n; photoDR_n; photoOP_n; ion_n; dep_n];

end