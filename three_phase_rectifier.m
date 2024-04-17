% ID Number: 229,506
% ECE 31033 - Project #3
% three_phase_rectifier.m
% Problem #2

% Initialization
param_init;
Ldc = 5e-3;

%% Processing
while (t_vec(k) < tend)
    Eas(k) = Eamp * cos(Wac * t_vec(k));
    Ebs(k) = Eamp * cos(Wac * t_vec(k) - phi);
    Ebs(k) = Eamp * cos(Wac * t_vec(k) + phi);

    if (ias(k) > esp)
        Vag(k) = Vdc_p(k);
    elseif (ias(k) < -esp)
        Vag(k) = 0;
    else
        Vag(k) = (Vdc_p(k) / (2 * esp)) * ias(k) + (0.5 * Vdc_p(k));
    end
    
    if (ibs(k) > esp)
        Vbg(k) = Vdc_p(k);
    elseif (ibs(k) < -esp)
        Vbg(k) = 0;
    else
        Vbg(k) = (Vdc_p(k) / (2 * esp)) * ibs(k) + (0.5 * Vdc_p(k));
    end
    
    if ics(k) > esp
        Vcg(k) = Vdc_p(k);
    elseif (ics(k) < -esp)
        Vcg(k) = 0;
    else
        Vcg(k) = (Vdc_p(k) / (2 * esp)) * ibs(k) + (0.5 * Vdc_p(k));
    end

    V_a(k) = (1/3) * (2 * V_aL(k) + V_bL(k) + V_cL(k));
    V_b(k) = (1/3) * (2 * V_bL(k) + V_aL(k) + V_cL(k));
    V_a(k) = (1/3) * (2 * V_cL(k) + V_aL(k) + V_bL(k));

    ias(k + 1) = ias(k) + dt * (Eas(k) - Va(k)); 
    ibs(k + 1) = ibs(k) + dt * (Ebs(k) - Vb(k));
    ics(k + 1) = ics(k) + dt * (Ecs(k) - Vc(k));

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

    %Vdc_p(k + 1) = ;
    Vdc(k + 1) = R_load * i_dc(k + 1);
    
    t_vec(k + 1) = tt_vec(k) + dt;
    k = k + 1;
end

%% Post Proccessing 

%% Plotting