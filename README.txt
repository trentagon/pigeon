{\rtf1\ansi\ansicpg1252\cocoartf2513
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red52\green52\blue52;\red0\green0\blue0;\red255\green255\blue255;
\red27\green31\blue35;\red27\green31\blue35;\red52\green52\blue52;}
{\*\expandedcolortbl;;\csgray\c26515;\csgray\c0\c0;\cssrgb\c100000\c100000\c100000;
\cssrgb\c14118\c16078\c18431;\cssrgb\c14118\c16078\c18431;\csgray\c26515;}
\margl1440\margr1440\vieww21260\viewh16220\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs24 \cf2 \cb3                               ,_   \
                             >' )       \
       (_)                   ( ( \\\
  _ __  _  __ _  ___  ___  _ _''|\\ \
 | '_ \\| |/ _` |/ _ \\/ _ \\| '_ \\ \
 | |_) | | (_| |  __/ (_) | | | |\
 | .__/|_|\\__, |\\___|\\___/|_| |_|\
 | |       __/ |                 \
 |_|      |___/                  \
 \
A model that tracks the [E]volution [O]f [N]itrogen on Mars\
By Trent Thomas and Renyu Hu\cb1 \
\pard\pardeftab720\partightenfactor0
\cf2 \cb4 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec5 \
This set of Matlab codes runs our model for the evolution of nitrogen in the Martian atmosphere over the last 3.8 billion years - A.K.A. \'93PIGEON\'94. This model is described in Renyu Hu and Trent B. Thomas (2022) \'93A Nitrogen-Rich Atmosphere on Ancient Mars Indicated by Isotopic Evolution\'94, Nature Geoscience. This model is mainly designed to recreate the representative cases in Figure 2 in the main text, but can be adapted to recreate other figures.\
\
\pard\pardeftab720\partightenfactor0
\cf2 \outl0\strokewidth0 As a matter of courtesy, we request that people using this code please cite Hu and Thomas (2022). In the interest of an "open source" approach, we also request that authors who use and modify the code, please send a copy of papers and modified code to the authors (renyu.hu@jpl.nasa.gov and tbthomas@uw.edu)\outl0\strokewidth0 \strokec5 \
\pard\pardeftab720\partightenfactor0
\cf2 \
REQUIREMENTS: Matlab (this code was written in version 2018b)\
\
HOW TO RUN CODE:\
(1) Download the code file and make sure everything is in the same directory.\
(2) Open \'93pigeon_fly.m\'94\
	\'97> Set the path to the directory containing PIGEON.\
\pard\pardeftab720\partightenfactor0
\cf7 \outl0\strokewidth0 	\'97> Choose an input file (the default file recreates the dynamical solution in Fig. 2).\
	\'97> Modify parameters of your choice.\cf2 \outl0\strokewidth0 \strokec5 \
\pard\pardeftab720\partightenfactor0
\cf2 (3) Run \cf7 \outl0\strokewidth0 \'93pigeon_fly.m\'94\cf2 \outl0\strokewidth0 \strokec5 . Code will output plots of the evolution and print results in the Matlab console. \
\
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\
EXPLANATION OF CODE STRUCTURE:\
\
%% pigeon_fly.m\
This is the top-level script to run the model. Set the path, choose an input file, modify parameters, run the script.\
\
%% pigeon_main.m\
This is the function where all scientific calculations are contained. As input, it takes the structure \'93in\'94. As output, it gives the structure \'93out\'94. \
\
%% Input files\
There are 4 input files contained in the subdirectory \'93input_files\'94. Each file contains all of the scientific inputs required to run the model.\
\
%% Everything else\
Model functions are contained in the \'93functions\'94 subdirectory. External data used to run the model is contained in the subdirectory \'93data\'94.\
\
END EXPLANATION OF CODE STRUCTURE\
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\
}