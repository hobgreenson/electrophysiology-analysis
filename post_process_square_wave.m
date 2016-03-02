function y = post_process_square_wave(x, sr)
    % INPUT:
    %   x is assumed to be a square-wave; x > 0 when a ventral
    %   root is active and x == 0 when vental root is inactive.
    %   sr is the sample rate of the data stored in x, with units 
    %   samples / sec
    %
    % OUPUT:
    %   y is a "cleaned up" version of x; specifically, bursts that are
    %   likely to be noise are removed.
    % 
    % TOOLBOX DEPENDENCIES:
    %   none.
    
    start = (x(2:end) > 0) & (x(1:end-1) == 0);
    start = find([false;start]);
    stop = (x(2:end) == 0) & (x(1:end-1) > 0);
    stop = find([stop;false]);
    
    % eliminate edge bursts if any
    if ~isempty(start) && ~isempty(stop)
        if stop(1) < start(1)
            stop = stop(2:end);
        end
        if stop(end) < start(end)
            start = start(1:end-1);
        end
    else
        start = [];
        stop = [];
    end
    assert(length(start) == length(stop));
    
    if (length(start) > 1)
        
        % delete bursts that are impossibly short:
        bd = stop - start;
        bd_thresh = 0.005 * sr;
        start(bd < bd_thresh) = [];
        stop(bd < bd_thresh) = [];
        assert(length(start) == length(stop));
        
        % merge bursts that are too close together:
        ibi_thresh = 0.007 * sr;
        ibi = start(2:end) - stop(1:end-1);
        bad = ibi < ibi_thresh;
        start([false;bad]) = [];
        stop([bad;false]) = [];
        assert(length(start) == length(stop));
        
        % delete bursts with uncommonly high frequency > 50 and shorter
        % duration than neighboring bursts (likely noise and not fast
        % swimming).
        ibi_thresh = sr / 50;
        ibi = start(2:end) - start(1:end-1);
        bad = find(ibi <= ibi_thresh);
        if ~isempty(bad)
            keep = false(size(bad));
            for i = 1:length(bad)
                prev = max([bad(i) - 1, 1]);
                next = min([bad(i) + 1, length(start)]);
                curr = bad(i);
                if (bd(curr) < bd(prev)) && (bd(curr) < bd(next))
                    keep(i) = true;
                end
            end
            bad = bad(keep);
            start(bad) = [];
            stop(bad) = [];
        end
    end
    
    y = zeros(size(x));
    for i = 1:length(start)
        y(start(i):stop(i)) = 5; 
    end
end