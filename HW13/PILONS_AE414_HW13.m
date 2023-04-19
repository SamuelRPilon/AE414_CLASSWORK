% SAMUEL R PILON
% AE 414 - HW13
% For personal use of SAMUEL PILON only. Not to be distributed

% Clear the command window, close any open figures, and reset the display format.
clc; 
close; 
clear; 

%% Given Parameters

ge = 9.81; % acceleration due to gravity [m/s^2]
ISP = 0:10:5000; % specific impulse [s]

% Mercury Fuel
mhg  = 3.33*10^-25; % mass of mercury [kg]
qmhg= 4.80*10^5; % specific energy of mercury fuel [C/kg]

% Xenon fuel 
mxe  = 2.18*10^-25; % mass of xenon [kg]
qmxe = 7.34*10^5; % specific energy of xenon fuel [C/kg]

% Krypton Fuel 
mkr = 1.39*10^-25; % mass of krypton [kg]
qmkr = 11.5*10^5; % specific energy of krypton fuel [C/kg]

% Argon Fuel 
mar = .66*10^-25; % mass of argon [kg]
qmar = 24.13*10^5; % specific energy of argon fuel [C/kg]

%% Calculations
% Mercury
Vahg= ((ISP*ge).^2)/(2*qmhg); % velocity of mercury fuel [m/s]
e1hg= (100+0.1.*Vahg)*1.6*10^-19; % ionization energy of mercury [J]
nhg = (.5*mhg.*ISP.^2*ge.^2)./(.5*mhg.*ISP.^2*ge.^2.+e1hg); % propellant efficiency of mercury
tphg= (2*nhg)./(ISP*ge); % thrust efficiency of mercury [s]

% Xenon 
Vaxe= ((ISP*ge).^2)/(2*qmxe); % velocity of xenon fuel [m/s]
e1xe= (100+0.1.*Vaxe)*1.6*10^-19; % ionization energy of xenon [J]
nxe = (.5*mxe.*ISP.^2*ge.^2)./(.5*mxe.*ISP.^2*ge.^2.+e1xe); % propellant efficiency of xenon
tpxe= (2*nxe)./(ISP*ge); % thrust efficiency of xenon [s]

% Krypton
Vakr= ((ISP*ge).^2)/(2*qmkr); % velocity of krypton fuel [m/s]
e1kr= (100+0.1.*Vakr)*1.6*10^-19; % ionization energy of krypton [J]
nkr = (.5*mkr.*ISP.^2*ge.^2)./(.5*mkr.*ISP.^2*ge.^2.+e1kr); % propellant efficiency of krypton
tpkr= (2*nkr)./(ISP*ge); % thrust efficiency of krypton [s]

% Argon
Vaar= ((ISP*ge).^2)/(2*qmar);% velocity of argon fuel [m/s]
e1ar= (100+0.1.*Vaar)*1.6*10^-19; % ionization energy of argon [J]
nar = (.5*mar.*ISP.^2*ge.^2)./(.5*mar.*ISP.^2*ge.^2.+e1ar); % propellant efficiency of argon
tpar= (2*nar)./(ISP*ge); % thrust efficiency of argon [s]

%% Plotting 

% Plot the Thrust to Power ratio vs ISP
figure % Create a new figure
hold on 

plot(ISP,tpxe,'LineWidth',2);
plot(ISP,tphg);
plot(ISP,tpkr);
plot(ISP,tpar);
xlabel('Specific Impulse (s)') % Adding label for x-axis
ylabel('Thrust to Power ratio (mN/kW)') % Adding label for y-axis
title('Thrust to Power ratio vs. Specific Impulse') % Adding title to the plot
legend('Xenon', 'Mercury', 'Krypton', 'Argon') % Adding a legend for the lines

grid on % Turning on grid lines
box on % Turning on box around the plot

set(gca, 'FontSize', 14) % Increasing font size of the tick labels
hold off % Turn off hold mode

% Plot the Thrust efficiency vs ISP
figure % Create a new figure
hold on

plot(ISP,nxe,'LineWidth',2);
plot(ISP,nhg);
plot(ISP,nkr);
plot(ISP,nar);
xlabel('Specific Impulse (s)') % Adding label for x-axis
ylabel('Thrust Efficiency') % Adding label for y-axis
title('Thrust Efficiency vs. Specific Impulse') % Adding title to the plot
legend('Xenon', 'Mercury', 'Krypton', 'Argon', 'Location', 'southeast') % Adding a legend for the lines and moving it to the bottom right corner

grid on % Turning on grid lines
box on % Turning on box around the plot

set(gca, 'FontSize', 14) % Increasing font size of the tick labels
hold off % Turn off hold mode
