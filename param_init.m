% ID Number: 229,506
% ECE 31033 - Project #3
% param_init.m

%% Initialization
Eamp = 392;     Wac = 377;     Lac = 1e-3;     k = 1;     phi = 2 * pi / 3;

dt = 1e-7;      Tac = 2 * pi / Wac;     tend = 10 * Tac;      t = 0:dt:(2 * (2 * pi / Wac)); 

ias = zeros(1, length(t));      ibs = zeros(1, length(t));      ics = zeros(1, length(t));

Eas = zeros(1, length(t));      Ebs = zeros(1, length(t));      Ecs = zeros(1, length(t));

Va = zeros(1, length(t));       Vb = zeros(1, length(t));       Vc = zeros(1, length(t));

Vag = zeros(1, length(t));      Vbg = zeros(1, length(t));      Vcg = zeros(1, length(t));

iD1 = zeros(1, length(t));      iD3 = zeros(1, length(t));      iD5 = zeros(1, length(t));

Vdc = zeros(1, length(t));      Vdc_p = zeros(1, length(t));    idc = zeros(1, length(t));

idc_M1 = zeros(1, length(t));   idc_M2 = zeros(1, length(t));   idc_M3 = zeros(1, length(t));

int_term = zeros(1, length(t)); theta = zeros(1, length(t));       

gamma = 45;     alpha = 10;     tau = 1e-5;     esp = 0.01;