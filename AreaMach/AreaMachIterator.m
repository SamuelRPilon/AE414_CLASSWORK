%% SAMUEL R PILON
% AE - Area Mach Solver
% Date - 03/29/2023
% For personal use of SAMUEL PILON only. Not to be distributed
%% PROGRAM PROPERTIES  
%{
Description: The Complex Area Ratio - Mach Number Solver is a program that helps solve the relationship 
between the Mach number and the complex area ratio of a fluid flow. The program is designed to provide an 
accurate and efficient solution to this complex relationship, which is often encountered in 
aerospace engineering and fluid mechanics.

Features:

Input Parameters: The program accepts the following input parameters from the user:
                  1) Free Stream Mach Number (M1)
                  2) Complex Area Ratio (A2/A1)

Output Results: The program calculates and provides the following output results:
                Exit Mach Number (Msub & Msup)

Calculation Method: The program uses the following equations to calculate
                    the output results:
                    M2/M1 = [(1 + γM1^2)/(γ+1)]^((γ+1)/(2γ-2)) x [A1/A2]^((γ-1)/γ)
                    where:
                    γ is the specific heat ratio of the fluid.
%}
%% INPUTS

% Define some paramters
g   = input('What is your gamma value: ');
gm1 = g-1;
gp1 = g+1;

% Define anonymous function with two inputs (M and ARatio)
% - Will be used in the methods below
% - Pass M and ARatio as arguments to AM_EQN to get function value
% -     funVal = AM_EQN(M,ARatio)
AM_EQN = @(M,ARatio) sqrt((1/M^2)*(((2+gm1*M^2)/gp1)^...
                            (gp1/gm1)))-ARatio;

% Solve for Msub and Msup using this area ratio (A/A*)
ARatio = input('What is your Area Ratio value: ');

% Error tolerance
errTol = 1e-4;
%% PLOT THE EQUATION

M       = linspace(0.03,5,100)';
A_Astar = sqrt((1./M.^2).*(((2+gm1.*M.^2)/gp1).^(gp1/gm1)));

figure(1);
cla; hold on; grid on; box on;
plot(A_Astar,M,'r-','LineWidth',3);
xlabel('$\frac{A}{A^*}$','Interpreter','Latex','FontSize',22,...
                            'FontName','NewTimesRoman');
ylabel('$M$','Interpreter','Latex','FontSize',22,...
                            'FontName','NewTimesRoman');
%% MATLAB SOLVER
% Set up the solver
problem.objective = @(M) (1/M^2)*(((2+gm1*M^2)/gp1)^(gp1/gm1))-ARatio^2;    % Objective function
problem.solver    = 'fzero';                                                % Find the zero
problem.options   = optimset(@fzero);                                       % Default options

% Solve subsonic root
problem.x0 = [1e-6 1];                                                      % Subsonic solver bounds
Msub       = fzero(problem);                                                % Solve for subsonic M
problem.x0 = [1+1e-6 50];                                                   % Supersonic solver bounds
Msup       = fzero(problem);                                                % Solve for supersonic M

% Print solutions to command window
fprintf('==== MATLAB SOLVER ====\n');
fprintf('Msub: %3.4f\n',Msub);
fprintf('Msup: %3.4f\n',Msup);
fprintf('=======================\n\n');

