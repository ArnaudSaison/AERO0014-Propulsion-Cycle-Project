function printOutput(c, p, r)
%printOutput prints all the temperatures and pressures in the cycle
%   
% Inputs:
%   p       parameters
%   c       config
%   r       results
%
% Ouput: -
%
% Calls: -
%

style = '%-8.2f';
spacing = '    ';

disp(' ')
disp(' ')
disp(['Cycle under <strong>', c.operation, '</strong> operation'])
disp('--------------------------------------------')
disp(['p0_1 = ', sprintf(style, p.p0_1/1e3), ' [kPa]', spacing, ...
      'T0_1 = ', sprintf(style, p.T0_1), ' [K]'])

disp(['p0_2 = ', sprintf(style, r.p0_2/1e3), ' [kPa]', spacing, ...
      'T0_2 = ', sprintf(style, r.T0_2), ' [K]'])

disp(['p0_3 = ', sprintf(style, r.p0_3/1e3), ' [kPa]', spacing, ...
      'T0_3 = ', sprintf(style, r.T0_3), ' [K]'])

disp(['p0_4 = ', sprintf(style, r.p0_4/1e3), ' [kPa]', spacing, ...
      'T0_4 = ', sprintf(style, r.T0_4), ' [K]'])

disp(['p0_4p= ', sprintf(style, r.p0_4_turb/1e3), ' [kPa]', spacing, ...
      'T0_4p= ', sprintf(style, r.T0_4_turb), ' [K]'])

disp(['p0_5 = ', sprintf(style, r.p0_5/1e3), ' [kPa]', spacing, ...
      'T0_5 = ', sprintf(style, r.T0_5), ' [K]'])

disp(['p0_5p= ', sprintf(style, r.p0_5_duct/1e3), ' [kPa]', spacing, ...
      'T0_5p= ', sprintf(style, r.T0_5_duct), ' [K]'])

disp(['p0_6 = ', sprintf(style, r.p0_6/1e3), ' [kPa]', spacing, ...
      'T0_6 = ', sprintf(style, r.T0_6), ' [K]'])

disp(['p0_7 = ', sprintf(style, r.p0_7/1e3), ' [kPa]', spacing, ...
      'T0_7 = ', sprintf(style, r.T0_7), ' [K]'])

disp(['p0_8 = ', sprintf(style, r.p0_8/1e3), ' [kPa]', spacing, ...
      'T0_8 = ', sprintf(style, r.T0_8), ' [K]'])

disp(['p_8  = ', sprintf(style, r.p_8/1e3), ' [kPa]', spacing, ...
      'T_8  = ', sprintf(style, r.T_8), ' [K]'])



end

