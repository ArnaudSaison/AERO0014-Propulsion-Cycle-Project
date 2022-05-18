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

disp(' ')
disp(' ')
disp(['Cycle under <strong>', c.operation, '</strong> operation'])
disp('--------------------------------------------')
disp(['p0_1 = ', num2str(p.p0_1/1e3, '%-12.2f'), ' [kPa]'])
disp(['T0_1 = ', num2str(p.T0_1, '%-12.2f'), ' [K]'])
disp(' ')

disp(['p0_3 = ', num2str(r.p0_3/1e3, '%-12.2f'), ' [kPa]'])
disp(['T0_3 = ', num2str(r.T0_3, '%-12.2f'), ' [K]'])
disp(' ')

disp(['p0_4 = ', num2str(r.p0_4/1e3, '%-12.2f'), ' [kPa]'])
disp(['T0_4 = ', num2str(r.T0_4, '%-12.2f'), ' [K]'])
disp(' ')


end

