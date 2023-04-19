%% SAMUEL R PILON
% AE 414 - HW12
% For personal use of SAMUEL PILON only. Not to be distributed

% Clear the command window, close any open figures, and reset the display format.
clc; 
close; 
clear; 

%% Given Parameters
gamma = 1.32;  % Specific heat ratio of the gas
Po = 10e6; % Pa  % Chamber pressure
To = 1100; % K  % Chamber temperature
Ae_At = 100;  % Area ratio of the nozzle
eff = 0.88;  % Nozzle efficiency
MW = 32; % kg/kmol  % Molecular weight of the gas
R = 259.8; % J/(kg*K)  % Specific gas constant
Pe = 3733; % Pa  % Exit pressure
ue = 1417.8; % m/s  % Exit velocity
ISP = 144.43; % s  % Specific impulse
T = 1; % N  % Desired thrust
diameter = linspace(0, 0.5, 700);  % Array of nozzle diameters to test


%% Initialization of differentials
% Initialize variables for finding diameter producing thrust closest to 1N
min_diff = Inf;  % Set minimum difference to infinity
min_diff_diameter = NaN;  % Set minimum difference diameter to NaN

%% Main Calculation
% Calculate parameters for each diameter in the array
At = (pi/4).*(diameter/1000).^2;  % Calculate throat area in m^2
Ae = Ae_At.*At;  % Calculate exit area in m^2
mdot = (Po.*At.*sqrt(gamma))./(sqrt(R.*To)).*(((2/(gamma+1))^((gamma+1)/(gamma-1))))^.5;  % Calculate mass flow rate in kg/s
ueq = ue+((Pe)./mdot).*Ae;  % Calculate equivalent exit velocity in m/s
T = ueq.*mdot;  % Calculate thrust in N

%% Loop to determine the closest value to T=1
% Find diameter that produces thrust closest to 1N
for i = 1:length(diameter)
    diff = abs(T(i) - 1);  % Calculate the difference between calculated thrust and 1N
    if diff < min_diff  % If the difference is smaller than the current minimum difference
        min_diff = diff;  % Set the new minimum difference
        min_diff_diameter = diameter(i);  % Set the diameter that produces the new minimum difference
    end
end

disp(['The diameter that produces thrust closest to 1N is ' num2str(min_diff_diameter) ' m.'])  % Display the result


plot(diameter,T,'LineWidth',1.5);
title('Thrust vs Diameter');
xlabel('Nozzle Diameter (m)');
ylabel('Thrust (N)');
grid minor;

% Add red dotted lines at y=1 and x=0.26466
hold on;
xline(0.26466,'r--','LineWidth',1.5);
yline(1,'r--','LineWidth',1.5);
hold off;
txt = {'Thrust = 1N','Diameter = 0.26466'};
text(.15,1.25,txt);
