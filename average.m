% ID Number: 229,506
% ECE 31033 - Project #3
% average.m

function avg = average(x, T, dt)
    N = T / dt;
    avg = 0;
    
    for k = 1:N
        avg = avg + x(k) * dt / T;
    end