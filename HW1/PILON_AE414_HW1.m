%% Author: Samuel Pilon 

clc 
clear 
close all 

%% Question 3: 
%  A sounding rocket has a takeoff mass of 1,860 kg, an initial propellant mass of 1,105 kg, an Isp of 
%  156 s and mass flow rate of 15.79 kg/s.  Plot the vehicle altitude, velocity and acceleration vs 
%  time from liftoff to max altitude neglecting the drag.  Hint, after the burnout time the equations 
%  are different. 
%% Given Information: 
Isp = 156;    % Specific Impulse 
ge = 9.81;    % Gravtiy on Earth 
Mdot = 15.79; % Mass Flow Rate
Mp = 1105;    % Propellant Mass
Mo = 1860;    % Initial Takeoff Mass 

%% Initial Calculations for More Information 

tb = Mp/Mdot;         % Time Until burnout 
R = Mo/(Mo-Mp);     
Veq = Isp*ge;         % Equalivent Velocity 
t=linspace(0,tb,1000);% Time span
tAF=(-Veq*log(1-(1-(1/R)).*tb/tb)-ge.*tb)/ge;
tABP=linspace(0,tAF,1000);
g=ge./t.*t;


%% Calculations 

ALTB=(Veq.*tb.*R)/(R-1).*((1-(1-(1/R)).*t/tb).*log((1-(1-(1/R)).*t/tb))-(1-(1-(1/R))*t/tb)+1)-0.5.*ge.*t.^2; % height of the Burn
V=-Veq*log(1-(1-(1/R)).*t/tb)-ge.*t; % Velocity of the Burn
ALTAB=max(V)*tABP-0.5*ge.*tABP.^2+max(ALTB); % Altitude after Burn

VAF=-Veq*log(1-(1-(1/R)))-ge.*tb-ge*tABP; % Velocity after Burn

Acceleration=(-(R-1).*Veq)./(t.*(R-1)-R.*tb); % Acceleration after Burn 

%% ALL THE PLOTS
Plot1 = subplot(3,1,1);
hold on;
grid on;
plot(t,ALTB,'r',tb+tABP,ALTAB,'b');
xlabel(Plot1, 'Time (s)');
ylabel(Plot1, 'Altitude (m)');
title('Altitude Vs Time');
hold off;

Plot2 = subplot(3,1,2);
grid on;
hold on;
plot(t,V,'r',tb+tABP,VAF,'b');
xlabel(Plot2, 'Time (s)');
ylabel(Plot2, 'Velocity (m/s)');
title('Velocity Vs Time');

hold off;

Plot3 = subplot(3,1,3);
hold on;
grid on;
plot(t,Acceleration,'r',tb+tABP,-g, 'b');
A = [69.98 69.98];
B = [32.01 -9.81];
plot(A,B,'g');
xlabel(Plot3, 'Time (s)');
ylabel(Plot3, 'Acceleration (m/s^2)');
title('Acceleration Vs Time');
hold off;




