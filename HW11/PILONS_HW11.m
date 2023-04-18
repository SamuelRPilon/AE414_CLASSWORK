%% Samuel R Pilon
% AE 414 - HW11
% For personal use of Samuel R Pilon only. Not to be distributed.

% Clear the command window, clear all variables, and close all figures.
clc;
clear;
close all;

%% Problem 1
% An electric rocket is to be designed to provide a Δub of 5.7 km/s. Given
% that the “burn” time is 90 days, and (α/η) is 10 kg/kW, calculate the
% optimum specific impulse, and the corresponding (ML/M0). Furnish either
% a table or a plot of Isp-(ML/M0) values to support your conclusion and
% highlight the necessary information in it. {Ans.: 3700s}

% Define the range of specific impulse (ISP) values to consider.
ISP = 0:5:10000; % span over 5000 s

% Define the burn time and (α/η) parameters.
deltaUBURN = 5.7*10^3; % delta U burn (m/s)
tb = 90*24*60*60; % time burn (s)
an3 = 10/(10^3); % kg/kW

% Calculate the exhaust velocity for each ISP value.
Ue = ISP*9.81;

% Calculate the payload ratio (ML/M0) for each ISP value.
mlmo = ((exp(-deltaUBURN./Ue)).*(1+(an3.*((Ue.^2)./(2.*tb))))-((an3.*((Ue.^2)./(2.*tb)))));

% Find the ISP value that gives the maximum payload ratio, and the
% corresponding payload ratio.
[mlmo_OPT, i] = max(mlmo);
ISP_OPT = ISP(i);

% Print the optimal ISP and optimal payload ratio.
fprintf('\n%%%% Problem 1 %%%%');
fprintf('\nOptimal Isp: %d (s)\n', ISP_OPT);
fprintf('Optimal Payload Ratio: %f\n\n', mlmo_OPT);

%% Problem 2
% Reconsider Problem 1. If the specific impulse is selected to be 80% of
% the optimum value, and (ML/M0) is maintained at the optimum value, what
% value of Δub will be achieved? {Ans.: 5.5 km/s}

% Calculate the exhaust velocity for 80% of the optimal ISP value.
ISP2 = 0.8*ISP_OPT;
Ue2 = ISP2*9.81;

% Calculate the burnout velocity for (ML/M0) maintained at the optimum value.
deltaUBURN2 = -1*(Ue2)*log((mlmo_OPT+((an3/(2*tb))*(Ue2^2)))/(1+(an3/(2*tb))* (Ue2^2)));

% Print the burnout velocity achieved.
fprintf('\n%%%% Problem 2 %%%%');
fprintf('\nDelta U_burn at 80 percent optimal ISP: %d (m/s)\n', deltaUBURN2);
fprintf('Optimal Payload Ratio: %f\n\n', mlmo_OPT);


%% Problem 3
%{ 
Reconsider Problem 1. If the value of (α/η) is reduced to 5 kg/kW,
what will be (ML/M0) at the optimum specific impulse value of Problem 1? 
Is this the optimum specific impulse with the new (α/η)? If not, what is 
the new optimum and the corresponding (ML/M0)? Again, provide either a 
table or a plot of Isp-(ML/M0) values to support your conclusion, and highlight
 the necessary information in it. {Ans.: 0.7931, first part}
%}

% set a new value for (α/η)
an3 = 5/(10^3);

% calculate the corresponding (ML/M0) for each specific impulse in the range
mlmo3 = ((exp(-deltaUBURN./Ue)).*(1+(an3.*((Ue.^2)./(2.*tb)))))-((an3.*((Ue.^2)./(2.*tb))));

% plot the results for the original (α/η) value and the new one
hold on;

mlmo_OPT1 = mlmo3(i); % store the optimal (ML/M0) for the original (α/η) value

[mlmo_OPT3, J] = max(mlmo3); % find the optimal (ML/M0) for the new (α/η) value
ISP_OPT3 = ISP(J); % find the corresponding optimal specific impulse

% print out the results
fprintf('\n');
fprintf('\n%%%% Problem 3 %%%%');
fprintf('\nPayload ratio from problem 1 optimal Isp: %f', mlmo_OPT1); 
fprintf('\nNew Optimal Isp: %d [s]', ISP_OPT3);
fprintf('\nNew Optimal Payload Ratio: %f', mlmo_OPT3);

% plot the two curves on the same graph
plot(ISP, mlmo, 'r', 'LineWidth',2);
plot(ISP,mlmo3,'b', 'LineWidth',2);
scatter(ISP(i), mlmo(i), 'filled', 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r');
scatter(ISP(J), mlmo3(J), 'filled', 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'b');

grid minor
title('Payload Ratio vs $I_{sp}$', 'Interpreter', 'latex','FontSize', 16);
xlabel('$Isp$ (s)', 'Interpreter', 'latex','FontSize', 14);
ylabel('$M_L/M_0$', 'Interpreter', 'latex','FontSize', 14);
legend('Optimal $M_L/M_0$ with $\alpha/\eta=10$ kg/kW', 'Optimal $M_L/M_0$ with $\alpha/\eta=5$ kg/kW','MAX POINT $M_L/M_0$ with $\alpha/\eta=10$ kg/kW', 'MAX POINT $M_L/M_0$ with $\alpha/\eta=5$ kg/kW', 'Interpreter', 'latex', 'FontSize', 12,'Location', 'southwest');




