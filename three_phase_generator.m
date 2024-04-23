% ID Number: 229,506
% ECE 31033 - Project #3
% three_phase_generator.m
% Problem #1

%% Initialization 
param_init;
theta_ac = 0:5:360;

%% Calculations (part A & D) -------------------------------------
idc_M1 = [0:0.001:sqrt(3) * Eamp / (4 * Wac * Lac)];
idc_M2 = [sqrt(3) * Eamp / (4 * Wac * Lac):0.001:(3 * Eamp / (4 * Wac * Lac))];
idc_M3 = [3 * Eamp / (4 * Wac * Lac):0.001:(Eamp / (Wac * Lac))];

Vdc_M1 = (3*sqrt(3) * Eamp / pi) - (3.* Wac .* Lac .* idc_M1 ./ pi);
Vdc_M2 = (9 * Eamp / (2 * pi)) .* (sqrt(1- (((2 .* Wac .* Lac * idc_M2) ./ (sqrt(3)* Eamp)).^2) ));
Vdc_M3 = (9 * Eamp / (2 * pi)) .* (2 - (2 .* idc_M3 .* Wac .* Lac) ./ (Eamp));

Pout = Vdc_M2 .* idc_M2;
Rload = Vdc_M2 ./ idc_M2;

[Pmax, Pmax_index] = max(Pout);
Rload_max_power = Rload(Pmax_index);

%% Post Processing (part A)
disp("Mode 1")
disp("  Idc (lower) = " + idc_M1(1) + "     Idc (upper) = " + idc_M1(end));
disp("  Vdc (lower) = " + Vdc_M1(1) + "     Vdc (upper) = " + Vdc_M1(end));

disp("Mode 2")
disp("  Idc (lower) = " + idc_M2(1) + "     Idc (upper) = " + idc_M2(end));
disp("  Vdc (lower) = " + Vdc_M2(1) + "     Vdc (upper) = " + Vdc_M2(end));

disp("Mode 3")
disp("  Idc (lower) = " + idc_M3(1) + "     Idc (upper) = " + idc_M3(end));
disp("  Vdc (lower) = " + Vdc_M3(1) + "     Vdc (upper) = " + Vdc_M3(end));

I_12 = idc_M2(1);       V_12 = Vdc_M2(1);       Rload_12 = V_12 / I_12;
I_23 = idc_M3(2);       V_23 = Vdc_M3(1);       Rload_23 = V_23 / I_23;

%% Plotting (part A)
figure;
sgtitle('V_{dc} vs I_{dc}');

plot(idc_M1, Vdc_M1, 'r');
hold on;
lp_M1 = [idc_M1(end), Vdc_M1(end)];

plot(idc_M2, Vdc_M2, 'b');
lp_M2 = [idc_M2(end), Vdc_M2(end)];

plot(idc_M3, Vdc_M3, 'g');
lp_M3 = [idc_M3(end), Vdc_M3(end)];

text(lp_M1(1), lp_M1(2), sprintf('(%.2f, %.2f)', lp_M1(1), lp_M1(2)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(lp_M2(1), lp_M2(2), sprintf('(%.2f, %.2f)', lp_M2(1), lp_M2(2)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(lp_M3(1), lp_M3(2), sprintf('(%.2f, %.2f)', lp_M3(1), lp_M3(2)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

xlabel('I_{dc} (A)');
ylabel('V_{dc} (V)');
legend('Mode 1', 'Mode 2', 'Mode 3');

%% Post Processing (part D)
disp("Pout (min) = " + min(Pout) + "    Pout (max) = " + max(Pout));
disp("Rload (min) = " + min(Rload) +"   Rload (max) = " + max(Rload));

%% Plotting (part D)
figure;
sgtitle('Power Output vs Load Resistance');
plot(Rload, Pout);
xlabel('R_{load} (\Omega)');
ylabel('P_{out} (W)');
text(max(Rload), max(Pout), sprintf('(%0.2f, %0.2e)', max(Rload), max(Pout)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

%% Calculations (part B) -------------------------------------
V_dc_b = ((3 * sqrt(3) * Eamp) / (2 * pi)) * (cosd(gamma) + 1);
i_dc_b = (pi / (3 * Wac * Lac)) * (((3 * sqrt(3) * Eamp) / pi) - V_dc_b);
i_ac_phaseA = zeros(size(theta_ac));

pos = (theta_ac <= 60 | theta_ac >= 300 + gamma);
neg = (theta_ac >= 120 + gamma & theta_ac <= 240);
n_slope_1 = (theta_ac > 60 & theta_ac < 60 + gamma);
n_slope_2 = (theta_ac > 120 & theta_ac < 120 + gamma);
p_slope_1 = (theta_ac > 240 & theta_ac < 240 + gamma);
p_slope_2 = (theta_ac > 300 & theta_ac < 300 + gamma);
zero = (theta_ac >= 60 + gamma & theta_ac <= 120) | (theta_ac >= 240 + gamma & theta_ac <= 300);

i_ac_phaseA(pos) = i_dc_b;
i_ac_phaseA(neg) = -i_dc_b;
i_ac_phaseA(n_slope_1) = -(i_dc_b/45).*(theta_ac(n_slope_1)-60) + i_dc_b;
i_ac_phaseA(n_slope_2) = -(i_dc_b/45).*(theta_ac(n_slope_2)-120);
i_ac_phaseA(p_slope_1) = (i_dc_b/45).*(theta_ac(p_slope_1)-240) - i_dc_b;
i_ac_phaseA(p_slope_2) = (i_dc_b/45).*(theta_ac(p_slope_2)-300);
i_ac_phaseA(zero) = 0;

i_ac_phaseB = circshift(i_ac_phaseA, [-1, -round(120/5)]);  % Shift by -2pi/3
i_ac_phaseC = circshift(i_ac_phaseA, [-1, round(120/5)]);   % Shift by +2pi/3

%% Plotting (part B) 
figure;
sgtitle('Phase Currents vs \theta_{ac} (part B)');

subplot(3, 1, 1);
plot(theta_ac, i_ac_phaseA);
xlabel('\theta_a_c (deg)');
ylabel('I_{as} (A)');
title('Phase A current vs \theta_a_c');

subplot(3, 1, 2);
plot(theta_ac, i_ac_phaseB);
xlabel('\theta_a_c (deg)');
ylabel('I_{bs} (A)');
title('Phase B current vs \theta_a_c');

subplot(3, 1, 3);
plot(theta_ac, i_ac_phaseC);
xlabel('\theta_a_c (deg)');
ylabel('I_{cs} (A)');
title('Phase C current vs \theta_a_c');

%% Calculations (part C) -------------------------------------
alpha = 15;
V_dc_c = ((9 * Eamp) / (2 * pi)) * cosd(alpha + 30);
i_dc_c = ((sqrt(3) * Eamp) / (2 * Wac * Lac)) * sind(alpha + 30);
i_ac_phaseA = zeros(size(theta_ac));

pos = (theta_ac >= alpha & theta_ac <= 60 + alpha);
neg = (theta_ac >= 180 + alpha & theta_ac <= 240 + alpha);
n_slope_c = (theta_ac > 60 + alpha & theta_ac < 180 + alpha);
p_slope_c_1 = (theta_ac < alpha);
p_slope_c_2 = (theta_ac > 240 + alpha);

i_ac_phaseA(pos) = i_dc_c;
i_ac_phaseA(neg) = -i_dc_c;
i_ac_phaseA(n_slope_c) = -(i_dc_c/60)*(theta_ac(n_slope_c)-60-alpha) + i_dc_c;
i_ac_phaseA(p_slope_c_1) = (i_dc_c/60)*(theta_ac(p_slope_c_1)+60-alpha);
i_ac_phaseA(p_slope_c_2) = (i_dc_c/60)*(theta_ac(p_slope_c_2)-240-alpha) - i_dc_c;

i_ac_phaseB = circshift(i_ac_phaseA, [-1, -round(120/5)]);  % Shift by -2pi/3
i_ac_phaseC = circshift(i_ac_phaseA, [-1, round(120/5)]);   % Shift by +2pi/3

%% Plotting (part C)
figure;
sgtitle('Phase Currents vs \theta_{ac} (part C)');

subplot(3, 1, 1);
plot(theta_ac, i_ac_phaseA);
xlabel('\theta_a_c (deg)');
ylabel('I_{as} (A)');
title('Phase A current vs \theta_a_c');

subplot(3, 1, 2);
plot(theta_ac, i_ac_phaseB);
xlabel('\theta_a_c (deg)');
ylabel('I_{bs} (A)');
title('Phase B current vs \theta_a_c');

subplot(3, 1, 3);
plot(theta_ac, i_ac_phaseC);
xlabel('\theta_a_c (deg)');
ylabel('I_{cs} (A)');
title('Phase C current vs \theta_a_c');