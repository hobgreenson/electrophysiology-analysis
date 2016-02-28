
function [l_duty, r_duty] = whole_bout_duty(l, r)

    [l_start, l_stop] = find_bursts(l);
    [r_start, r_stop] = find_bursts(r);
    
    if isempty(l_start)
        l_duty = 0;
    else
        l_duty = duty(l(l_start(1):l_stop(end)));
    end
    
    if isempty(r_start)
        r_duty = 0;
    else
        r_duty = duty(r(r_start(1):r_stop(end)));
    end
end