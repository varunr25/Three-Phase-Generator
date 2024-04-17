% ID Number: 229,506
% ECE 31033 - Project #3
% param_init.m

%% Initialization
Eamp = 392;     Wac = 377;     Lac = 1e-3;     k = 1;     phi = 2 * pi / 3;

dt = 1e-7;                  tend = 10 * 2 * pi / Wac;   t = linspace(0, tend, tend/dt);

ias = zeros(size(t));       ibs = zeros(size(t));       ics = zeros(size(t));

Eas = zeros(size(t));       Ebs = zeros(size(t));       Ecs = zeros(size(t));

Va = zeros(size(t));        Vb = zeros(size(t));        Vc = zeros(size(t));

Vag = zeros(size(t));       Vbg = zeros(size(t));       Vcg = zeros(size(t));

iD1 = zeros(1, size(t));    iD3 = zeros(1, size(t));    iD5 = zeros(1, size(t));

Vdc = zeros(1, size(t));    Vdc_p = zeros(1, size(t));  idc = zeros(1, size(t));    