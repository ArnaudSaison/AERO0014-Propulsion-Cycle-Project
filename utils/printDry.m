function printDry(c, p, r)
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
spacing = '    ';

disp('--------------------------------------------')

disp(['pi_LPC = ', sprintf(style, r.pi_LPC), ' [-]'])

disp(['eta_cs = ', sprintf(style, r.eta_cs*100), ' [%]'])

disp(['eta_ts = ', sprintf(style, r.eta_ts*100), ' [%]'])

disp(['Nozzle exhaust area = ', sprintf(style2, r.A_ex), ' [m^2]'])

disp(['Thrust = ', sprintf(style2, r.T*1e-3), ' [kN]'])

disp(['Target thrust = ', sprintf(style2, p.T*1e-3), ' [kN]'])

end

