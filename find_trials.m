function [start, stop] = find_trials(s, sr, debug)
    t = 2.51;
    start = find(s(2:end) > t & s(1:end-1) < t);
    stop = find(s(2:end) < t & s(1:end-1) > t);
    
    if start(1) > stop(1)
        stop = stop(2:end);
    end
    if start(end) > stop(end)
        start = start(1:end-1);
    end
    isi = stop - start;
    start = start(isi > sr);
    stop = stop(isi > sr);

    iti = start(2:end) - stop(1:end-1);
    good = iti >= sr;
    start = start([true;good]);
    stop = stop([good;true]);
    
    assert(length(start) == length(stop));
    
    if debug
        figure;
        sub = 1:5:length(s);
        hold on;
        plot(sub, s(sub), 'k');
        plot(start, s(start), 'og');
        plot(stop, s(stop), 'or');
        hold off;
        pause;
    end
end