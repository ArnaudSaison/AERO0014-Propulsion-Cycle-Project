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
spacing = '    ';

disp('--------------------------------------------')

disp(['lambda_ab = ', sprintf(style, r.lambda_ab), ' [%]'])

disp(['Nozzle exhaust area = ', sprintf(style, r.A_ex), ' [m^2]'])

disp(['Thrust = ', sprintf('%-.4f', r.T*1e-3), ' [kN]'])

disp(['Target thrust = ', sprintf('%-.4f', p.T_wet*1e-3), ' [kN]'])

end

