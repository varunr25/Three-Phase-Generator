% ID Number: 229,506
% ECE 31033 - Project #3
% main.m

%% Problem 1
disp("----------------Problem 1---------------------");
three_phase_generator;

%% Problem 2
% Initial Run
Rload = ((6 * Wac * Lac) / (pi *(1 - cos(gamma * pi / 180)))) - (3 * Wac * Lac / pi);

disp("----------------Problem 2---------------------");
disp("Initial Run-----------------------------------");
disp("Rload = " + Rload);

three_phase_rectifier;

% Similar to 1B
Rload = Rload_12;
disp("1b Conditions---------------------------------");
disp("Rload for 1B = " + Rload);

three_phase_rectifier;

% Similar to 1C
Rload = Rload_23;
disp("1c Conditions---------------------------------");
disp("Rload for 1C = " + Rload);

three_phase_rectifier;