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
% compressors ..............................
d.r.p0_3 = d.p.Pi * d.p.p0_1;

% combustion chamber .......................
[d.r.T0_3, d.r.T0_4] = combChamber(d.p.TiT, d.p.TiT, d.p.T0_r, 1, d.p.m_d_p - d.p.m_d_c, d.p.m_d_fcc, d.p.eta_cc, d.p.Deltah_f);
d.r.p0_4 = d.r.p0_3 * (1 - d.p.cham_tot_press_loss);

% coolant flow mixing ......................
d.r.T0_4_turb = mixer(d.r.T0_3, d.r.T0_4, d.p.T0_r, 0, d.p.m_d_fcc / (d.p.m_d_p - d.p.m_d_c), d.p.m_d_c, d.p.m_d_p);
d.r.p0_4_turb = d.r.p0_4;

% compressor ...............................
d.i.pi_c = 3.85; % guess
d.r.p0_2 = d.i.pi_c * d.p.p0_1;

[d.r.T0_2, d.r.eta_cs, d.r.P_c] = compressor(d.p.T0_1, d.r.T0_3, d.p.Pi, d.p.gamma, d.i.pi_c, d.p.m_d_p, d.p.m_d_a);

% turbine ..................................
d.r.P_t = d.r.P_c / d.p.eta_t;
[d.r.T0_5, d.r.C_p_t] = turbine(d.r.T0_4_turb, d.p.m_d_p, d.p.m_d_fcc, d.r.P_t, d.p.R);

% duct .....................................
d.r.T0_5_duct = d.r.T0_2;
d.r.p0_5_duct = d.r.p0_2 * (1 - d.p.duct_tot_press_loss);
d.r.p0_5 = d.r.p0_5_duct;

% turbine expansion ratio and iso-s eff
d.r.pi_t = d.r.p0_4_turb/d.r.p0_5;
d.r.eta_ts = turbIsoSEff(d.r.pi_t, d.r.T0_4_turb, d.r.T0_5, d.r.C_p_t, d.p.R);

% mixer ....................................
d.r.T0_6 = mixer(d.r.T0_5_duct, d.r.T0_5, d.p.T0_r, 0, d.p.m_d_fcc / d.p.m_d_p, d.p.m_d_s, d.p.m_d_p + d.p.m_d_fcc);
d.r.p0_6 = d.r.p0_5 * (1 - d.p.mixe_tot_press_loss);

% dry afterburner ..........................
d.r.T0_7 = d.r.T0_6;
d.r.p0_7 = d.r.p0_6;

% nozzle ...................................
% (isentropic => same tot temp and press)
d.r.p0_8 = d.r.p0_7;
d.r.T0_8 = d.r.T0_7;

% p0_1 = p_1 since v_0 = 0
[d.r.A_ex, d.r.v_8, d.r.p_8, d.r.T_8] = convNozzle(d.p.p0_1, d.r.p0_7 , d.r.T0_7, d.p.v_0, d.p.m_d_a, d.p.m_d_fcc, d.p.gamma, d.p.R, d.p.iter.tol, d.p.iter.max);

% thrust ...................................
d.r.T = thrust(d.p.m_d_a, d.p.m_d_fcc, d.r.v_8, d.p.v_0, d.r.p_8, d.p.p0_1, d.r.A_ex);



d.r.pi_c = d.i.pi_c;

% -------------------------------------------------------------------------
% Printing results
% -------------------------------------------------------------------------
printEndLog();
printDry(d.c, d.p, d.r); % dry (d), parameters (p) and configuration (c, should only be used for displaying)




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




%% Printing results










