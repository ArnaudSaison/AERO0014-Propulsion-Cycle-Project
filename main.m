%% AERO0014 Project - Advanced Cycle Analysis
% -------------------------------------------------------------------------
% Université de Liège
% AERO0014 Aerospace Propulsion
% Academic year: 2021-2022
% -------------------------------------------------------------------------
% Author: Arnaud Saison
% Date: 20 May 2022
% -------------------------------------------------------------------------
% Description:
%   This script solves the questions of the Advanced Cycle Analysis
%   project.
%
%   From the project statement:
%       "Provide an educated guess of the main performance parameters and
%       conditions in the cycle at ground conditions for both dry and wet
%       operation, using reasonable assumptions, tables providing Cp as a
%       function of temperature and fuel-to-air-ratio, as well as the fuel
%       lower heating value ∆hf = 42.8 MJ/kg."
%   
%   Denominations for the cycle stations (as required by the statement with
%   4p station added for clarity):
%       1  upstream of the LP compressor
%       2  downstream of the LPC / upstream of the HPC / inlet of the 
%          secondary flow duct; 
%       3  downstream of the HPC / inlet of the combustion chamber;
%       4  outlet of the combustion chamber / inlet of the HPT;
%       4p conditions after injection of the turbine coolant flow and 
%          before entering the inlet guide vane; 
%       5  outlet of the turbine / primary inlet of the mixer ;
%       5p outlet of the secondary duct / secondary inlet of the mixer; 
%       6  outlet of the mixer / inlet of the afterburner;
%       7  outlet of the afterburner / entry of the nozzle;
%       8  nozzle outlet.
%
%   Please note that outside the configuration file, all units are in SI.
%
% User Guide:
%   Each section solves one part of the assignment. Use the Run Section
%   command to selectively one part or another.
%
%   Configuration files may be edited and managed in the Configurations
%   folder following the 'config_example.m' file structure.
%
% File Structure of this project:
%   Configuration/
%       config_example.m            example configuration
%       config_dry.m                dry configuration of the afterburner
%       config_wet.m                wet configuration of the afterburner
%   Cycle/
%
%   Data/
%       C_p.m                       return the heat capacity at constant
%                                   pressure for a given temperature and
%                                   fuel to air ratio
%       constants.m                 contains all physical constants
%       
% Data Structure:
%   s       (struct)    main project setting
%   par     (struct)    contains all parameters
%   res     (struct)    contains all results
%


%% Initialization
% =========================================================================
addpath(genpath('.')); % use restoredefaultpath to reinitialize
clc; close all; clear;

% 1 to display logs in command window (verbose mode) / 0 for no log
s.verb1 = 0; % (bool) debugging

s.print2pdf = 0; % (bool) prints figures to PDF
s.fig_folder = 'Figures/'; % (string) subfolder in which figures pdfs are saved
s.fig_size = 0.75; % * 10 cm = vertical size of a figure

printStartLog();

%% Dry Operation
% =========================================================================
% First we proceed by computing the nominal thrust at ground conditions 
% for dry operation: 
% • estimate the LPC pressure ratio;
% • estimate the total-to-total isentropic efficiencies of compressors and 
%   turbines;
% • give the total temperature and pressure at all stations in the cycle;
% • provide a power balance;
% • give the area of the exhaust nozzle.

% -------------------------------------------------------------------------
% Configuration
% -------------------------------------------------------------------------
[d.p, d.c] = config_dry; % dry (d), parameters (p) and configuration (c, should only be used for displaying)

% -------------------------------------------------------------------------
% Cycle
% -------------------------------------------------------------------------
% Using the bissection method to find the LPC

d.i.pi_LPC_lims = [3, 5]; % first guess
d.r.T = 0; % initialization
d.i.iter = 1;

while abs(d.p.T - d.r.T) > d.p.iter.tol && d.i.iter <= d.p.iter.max
    % initalizing iteration ....................
    d.i.pi_LPC = (d.i.pi_LPC_lims(1) + d.i.pi_LPC_lims(2)) / 2;
    d.p.pi_LPC = d.i.pi_LPC;

    printLogIter(d.i.iter, d.i.pi_LPC);

    % run cycle ................................
    [d.p, d.c, d.r] = DRYcycleOperation(d.p, d.c);

    % checking iteration .......................
    if d.p.T > d.r.T
        d.i.pi_LPC_lims(1) = d.i.pi_LPC;
    else 
        d.i.pi_LPC_lims(2) = d.i.pi_LPC;
    end

    d.i.iter = d.i.iter + 1;

end

if abs(d.p.T - d.r.T) > d.p.iter.tol
    warning('No solution found for pi_LPC');
end

d.r.pi_LPC = d.p.pi_LPC;

% d.p.pi_LPC = 3.745;
% [d.p, d.c, d.r] = cycleOperation(d.p, d.c);
% 
% d.r.pi_LPC = d.p.pi_LPC;


%% Wet Operation
% =========================================================================
% The afterburner is activated and the nozzle is opened such that the 
% operation point of the gas turbine cycle as well as the mixer is 
% unmodified with respect to dry operation. Supposing that the cycle before 
% the afterburner is kept the same,
% • estimate the total pressure loss in the afterburner;
% • provide the conditions in the afterburner and nozzle.
% • provide the converging nozzle throat area;
% • supposing a converging-diverging nozzle is installed, compute the 
%   increase in thrust and provide the outlet area.

% -------------------------------------------------------------------------
% Configuration
% -------------------------------------------------------------------------
[w.p, w.c] = config_wet; % dry (d), parameters (p) and configuration (c, should only be used for displaying)


% -------------------------------------------------------------------------
% Cycle
% -------------------------------------------------------------------------
% operation unmodified before the efterburner
w.r.T0_2 = d.r.T0_2;
w.r.T0_3 = d.r.T0_3;
w.r.T0_4 = d.r.T0_4;
w.r.T0_4_turb = d.r.T0_4_turb;
w.r.T0_5 = d.r.T0_5;
w.r.T0_5_duct = d.r.T0_5_duct;
w.r.T0_6 = d.r.T0_6;

w.r.p0_2 = d.r.p0_2;
w.r.p0_3 = d.r.p0_3;
w.r.p0_4 = d.r.p0_4;
w.r.p0_4_turb = d.r.p0_4_turb;
w.r.p0_5 = d.r.p0_5;
w.r.p0_5_duct = d.r.p0_5_duct;
w.r.p0_6 = d.r.p0_6;

% Iteration to find the correct pressure loss in afterburner
w.i.lambda_ab_lims = [0.05, 0.15]; % first guess
w.r.T_wet = 0; % initialization
w.i.iter = 1;

while abs(w.p.T_wet - w.r.T_wet) > w.p.iter.tol && w.i.iter <= w.p.iter.max
    % initalizing iteration ....................
    w.i.lambda_ab = (w.i.lambda_ab_lims(1) + w.i.lambda_ab_lims(2)) / 2;
    w.p.lambda_ab = w.i.lambda_ab;

    printLogIter(w.i.iter, w.i.lambda_ab);

    % run cycle ................................
    [w.p, w.c, w.r] = WETcycleOperation(w.p, w.c, w.r);

    % checking iteration .......................
    if w.p.T_wet > w.r.T_wet
        w.i.lambda_ab_lims(2) = w.i.lambda_ab;
    else 
        w.i.lambda_ab_lims(1) = w.i.lambda_ab;
    end

    w.i.iter = w.i.iter + 1;

end

if abs(w.p.T_wet - w.r.T_wet) > w.p.iter.tol
    warning('No solution found for lambda_ab');
end

w.r.lambda_ab = w.p.lambda_ab;


%% Printing results
% =========================================================================
% DRY
printEndLog();
printDry(d.c, d.p, d.r); % dry (d), parameters (p) and configuration (c, should only be used for displaying)


% WET
printVSpace(5);
printWet(w.c, w.p, w.r);









