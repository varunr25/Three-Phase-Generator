% ID Number: 229,506
% ECE 31033 - Project #3
% average.m

function av = aver(x, T, dt)
    location = length(x);
    av = 0;
    time = 0;

    while (time <= T)
        if location == 0 
            break;
        end

        av = av + dt * (x(location));
        time = time + dt;
        location = location - 1;
    end

    av = av / T;
end