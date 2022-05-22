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
spacing = '    ';

disp('--------------------------------------------')

disp(['pi_LPC = ', sprintf(style, r.pi_c), ' [-]'])

disp(['eta_cs = ', sprintf(style, r.eta_cs), ' [-]'])

disp(['eta_ts = ', sprintf(style, r.eta_ts), ' [-]'])

disp(['Nozzle exhaust area = ', sprintf(style, r.A_ex), ' [m^2]'])

disp(['Thrust = ', sprintf(style, r.T*1e-3), ' [kN]'])

disp(['Target thrust = ', sprintf(style, p.T*1e-3), ' [kN]'])

end

