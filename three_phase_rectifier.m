% ID Number: 229,506
% ECE 31033 - Project #3
% three_phase_rectifier.m
% Problem #2

% Initialization
param_init;
Ldc = 5e-3;
tend = 2 * (2 * pi / Wac) - dt;

%% Processing
while (t(k) < tend)
    Eas(k) = Eamp * cos(Wac * t(k));
    Ebs(k) = Eamp * cos((Wac * t(k)) - phi);
    Ecs(k) = Eamp * cos((Wac * t(k)) + phi);

    if (ias(k) > esp)
        Vag(k) = Vdc_p(k);
    elseif (ias(k) < -esp)
        Vag(k) = 0;
    else
        Vag(k) = ((Vdc_p(k) * ias(k)) / (2 * esp))  + (Vdc_p(k) / 2);
    end
    
    if (ibs(k) > esp)
        Vbg(k) = Vdc_p(k);
    elseif (ibs(k) < -esp)
        Vbg(k) = 0;
    else
        Vbg(k) = ((Vdc_p(k) * ibs(k)) / (2 * esp)) + (Vdc_p(k) / 2);
    end
    
    if (ics(k) > esp)
        Vcg(k) = Vdc_p(k);
    elseif (ics(k) < -esp)
        Vcg(k) = 0;
    else
        Vcg(k) = ((Vdc_p(k) * ics(k)) / (2 * esp)) + (Vdc_p(k) / 2);
    end

    Va(k) = (1 / 3) * (2 * Vag(k) - Vbg(k) - Vcg(k));
    Vb(k) = (1 / 3) * (2 * Vbg(k) - Vag(k) - Vcg(k));
    Vc(k) = (1 / 3) * (2 * Vcg(k) - Vag(k) - Vbg(k));

    ias(k + 1) = ias(k) + (dt * (Eas(k) - Va(k)) / Lac); 
    ibs(k + 1) = ibs(k) + (dt * (Ebs(k) - Vb(k)) / Lac);
    ics(k + 1) = ics(k) + (dt * (Ecs(k) - Vc(k)) / Lac);

    if (ias(k + 1) > 0)
        iD1(k + 1) = ias(k + 1);
    else
        iD1(k + 1) = 0;
    end
    
    if (ibs(k + 1) > 0)
        iD3(k + 1) = ibs(k + 1);
    else
        iD3(k + 1) = 0;
    end
    
    if (ics(k + 1) > 0)
        iD5(k + 1) = ics(k + 1);
    else
        iD5(k + 1) = 0;
    end

    idc(k + 1) = iD1(k + 1) + iD3(k + 1) + iD5(k + 1);

    int_term(k + 1) = int_term(k) + ((dt * Rload * idc(k) - dt * Vdc_p(k)) / tau);
    Vdc_p(k + 1) = (Ldc * idc(k + 1)/ tau) + int_term(k + 1);
    
    theta(k + 1) = theta(k) + ((dt * Wac) * (180/pi)); 
    k = k + 1;
end

Vdc_avg = average(Vdc_p, Tac, dt);
idc_avg = average(idc, Tac, dt);

Pout_avg = Vdc_avg * idc_avg;

Pin = (Va .* ias) + (Vb .* ibs) + (Vc .* ics);
Pin_avg = average(Pin, Tac, dt);

eff = Pout_avg / Pin_avg;

disp("  Average Vdc: " + Vdc_avg);      disp("  Average idc: " + idc_avg);
disp("  Average Pout: " + Pout_avg);    disp("  Average Pin: " + Pin_avg);
disp("  Efficiency: " + eff);

%% Plotting
plot_length_x = theta(1:(length(theta) / 2));
plot_length_y = (length(theta)/2) + 1:length(theta);

figure;
sgtitle('Phase Currents vs {\theta_{ac}}');

subplot(3, 1, 1);
plot(plot_length_x, ias(plot_length_y));
title('Phase A current vs {\theta_{ac}}');
xlabel('{\theta_{ac} (degrees)}');
ylabel('ias (A)');

subplot(3, 1, 2);
plot(plot_length_x, ibs(plot_length_y));
title('Phase B current vs {\theta_{ac}}');
xlabel('{\theta_{ac} (degrees)}');
ylabel('ibs (A)');

subplot(3, 1, 3);
plot(theta(1 : length(theta)/2), ics(plot_length_y));
title('Phase C current vs {\theta_{ac}}');
xlabel('{\theta_{ac} (degrees)}');
ylabel('ics (A)');

figure;
sgtitle('Leg Voltages vs {\theta_{ac}}');

subplot(3, 1, 1);
plot(plot_length_x, Va(plot_length_y));
title('Va vs {\theta_{ac}}');
xlabel('{\theta_{ac} (degrees)}');
ylabel('Va (V)');

subplot(3, 1, 2);
plot(plot_length_x, Vb(plot_length_y));
title('Vb vs {\theta_{ac}}');
xlabel('{\theta_{ac} (degrees)}');
ylabel('Vb (V)');

subplot(3, 1, 3);
plot(plot_length_x, Vc(plot_length_y));
title('Vc vs {\theta_{ac}}');
xlabel('{\theta_{ac} (degrees)}');
ylabel('Vc (V)');

figure;
subplot(3, 1, 1);
plot(plot_length_x, int_term(plot_length_y));
title('Integration Term vs {\theta_{ac}}');
xlabel('{\theta_{ac} (degrees)}');
ylabel('Integration Term (V)');

subplot(3, 1, 2);
plot(plot_length_x, Vdc_p(plot_length_y));
title('Vdc vs {\theta_{ac}}');
xlabel('{\theta_{ac} (degrees)}');
ylabel('Vdc (V)');

subplot(3, 1, 3);
plot(plot_length_x, idc(plot_length_y));
title('idc vs {\theta_{ac}}');
xlabel('{\theta_{ac} (degrees)}');
ylabel('idc (A)');