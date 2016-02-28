function idx = find_spikes(x, thresh)
    % INPUTS:
    %   x is assumed to be a whole-cell patch record (1-D array);
    %   thresh is a voltage threshold (scalar).
    % If the patch record crosses the threshold, then a spike is assumed 
    % to have occurred.
    %
    % OUPUT:
    %   idx is an array of indices of x at which spikes occurred. may be
    % empty if no spikes were detected.
    %
    % TOOLBOX DEPENDENCIES:
    %   none.
    
    idx = find((x(1:end-1) < thresh) & (x(2:end) >= thresh)) + 1;
    
end