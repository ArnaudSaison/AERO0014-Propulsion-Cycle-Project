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
%   Denominations for the cycle stations (as required by the statement):
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
% User Guide:
%   Each section solves one part of the assignment. Use the Run Section
%   command to selectively one part or another.
%
%   Configuration files may be edited and managed in the Configurations
%   folder following the 'config_example.m' file structure.
%
%   Beware configurations files are scripts, not functions.
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
%   s       (struct)    
%   par     (struct)    contains all parameters
%   res     (struct)    contains all results
%


%% Initialization
% =========================================================================
addpath(genpath('.')); % use restoredefaultpath to reinitialize
clc; close all; clear;

% 1 to display logs in command window (verbose mode) / 0 for no log
s.verb1 = 0; % debugging

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








