%{
                              ,_   
                             >' )       
       (_)                   ( ( \
  _ __  _  __ _  ___  ___  _ _''|\ 
 | '_ \| |/ _` |/ _ \/ _ \| '_ \ 
 | |_) | | (_| |  __/ (_) | | | |
 | .__/|_|\__, |\___|\___/|_| |_|
 | |       __/ |                 
 |_|      |___/                  

A model that tracks the [E]volution [O]f [N]itrogen on Mars
By Trent Thomas and Renyu Hu

%}
%% Technical specifications

close all % close existing plots
clear all % clear workspace variables

pigeon_path = '/Users/tthomas/Desktop/pigeon'; 
% ^^^SET the path to your own PIGEON directory ^^^
% (unless you're me, you'll have to change this)

inputFileName = 'inputFile_fig2_dyn.m'; 
% ^^^SET the desired input file^^^

restoredefaultpath % clear the path
addpath(genpath(pigeon_path)); % add all subdirectories to path
run(inputFileName); % run the input file, which creates the "in" struct

%% Edit parameters
% Use this section to quickly edit the parameters specified in the input file
% in.whatever_parameter_you_want_to_change = value

% in.pn0 = 245; % initial pressure of n2
% in.zt = 0.35; %Distance from homopause to exobase divided by temperature, matters for diffusion
% in.euv_pl = 1.3; %Power law index for N2 photochemical loss via euv flux
% in.euv_uncertainty = 0; %Uncertainty in the euv flux evolution, [-0.1,0.1]
% in.f_photoN = 1; %Photochemical multiplier
% in.f_sputtering = 1; %Sputtering multiplier
% in.f_outgassing = 1; %Outgassing multiplier
% in.d_nit = 50; %Depth of early nitrate deposition [m]
% in.carbon_case = 3; % set the carbon evolution [1-5]

%% Run model and plot output

output = pigeon_main(in); % let the pigeon fly (run the model)
pigeon_print(output); % print some results
pigeon_plot(output); % plot some results


