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

This set of Matlab codes runs our model for the evolution of nitrogen in the Martian atmosphere over the last 3.8 billion years - A.K.A. “PIGEON”. This model is described in Renyu Hu and Trent B. Thomas (2022) “A Nitrogen-Rich Atmosphere on Ancient Mars Indicated by Isotopic Evolution”, Nature Geoscience. This model is mainly designed to recreate the representative cases in Figure 2 in the main text, but can be adapted to recreate other figures.

As a matter of courtesy, we request that people using this code please cite Hu and Thomas (2022). In the interest of an "open source" approach, we also request that authors who use and modify the code, please send a copy of papers and modified code to the authors (renyu.hu@jpl.nasa.gov and tbthomas@uw.edu)

REQUIREMENTS: Matlab (this code was written in version 2018b)

HOW TO RUN CODE:
(1) Download the code file and make sure everything is in the same directory.
(2) Open “pigeon_fly.m”
	—> Set the path to the directory containing PIGEON.
	—> Choose an input file (the default file recreates the dynamical solution in Fig. 2).
	—> Modify parameters of your choice.
(3) Run “pigeon_fly.m”. Code will output plots of the evolution and print results in the Matlab console. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EXPLANATION OF CODE STRUCTURE:

%% pigeon_fly.m
This is the top-level script to run the model. Set the path, choose an input file, modify parameters, run the script.

%% pigeon_main.m
This is the function where all scientific calculations are contained. As input, it takes the structure “in”. As output, it gives the structure “out”. 

%% Input files
There are 4 input files contained in the subdirectory “input_files”. Each file contains all of the scientific inputs required to run the model.

%% Everything else
Model functions are contained in the “functions” subdirectory. External data used to run the model is contained in the subdirectory “data”.

END EXPLANATION OF CODE STRUCTURE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%