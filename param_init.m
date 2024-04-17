% ID Number: 229,506
% ECE 31033 - Project #3
% param_init.m

%% Initialization
dt = 1e-7;                  tend = 100 * dt;            t = linspace(0, tend, tend/dt);

ias = zeros(size(t));       ibs = zeros(size(t));       ics = zeros(size(t));

Eas = zeros(size(t));       Ebs = zeros(size(t));       Ecs = zeros(size(t));

Vag = zeros(size(t));       Vbg = zeros(size(t));       Vcg = zeros(size(t));

iD1 = zeros(1, size(t));    iD3 = zeros(1, size(t));    iD5 = zeros(1, size(t));

Eamp = 392;                 Wac = 377;                  Lac = 1e-3;