function printWet(c, p, r)
%printDry prints results for dry operations
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

printOutput(c, p, r)

style = '%-.2f';
style2 = '%-.4f';
style3 = '%-8.2f';
spacing = '    ';

disp('--------------------------------------------')

disp(['lambda_ab = ', sprintf(style, r.lambda_ab*100), ' [%]'])

disp(['AB pressure ratio = ', sprintf(style2, 1-r.lambda_ab), ' [-]'])

disp(['Nozzle exhaust area = ', sprintf(style2, r.A_ex), ' [m^2]'])

disp(['Thrust = ', sprintf(style2, r.T_wet*1e-3), ' [kN]'])

disp(['Target thrust = ', sprintf(style2, p.T_wet*1e-3), ' [kN]'])

disp('--------------------------------------------')

disp(['con di thrust = ', sprintf(style2, r.cd.T_wet*1e-3), ' [kN]'])

disp(['con di thrust  increase= ', sprintf(style, (r.cd.T_wet-r.T_wet)/r.T_wet*100), ' [%]'])

disp(['con di exhaust area = ', sprintf(style2, r.cd.A_ex), ' [m^2]'])

disp(['p_8cd= ', sprintf(style3, r.cd.p_8/1e3), ' [kPa]', spacing, ...
      'T_8cd= ', sprintf(style3, r.cd.T_8), ' [K]'])

end

