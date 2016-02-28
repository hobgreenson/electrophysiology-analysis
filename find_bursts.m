function [start, stop] = find_bursts(x)
    % INPUT:
    %   x is assumed to be a square wave (1-D array) representing 
    % ventral root activity; x > 0 if ventral root is active otherwise
    % x == 0.
    %
    % OUPUT:
    %   start is an array of indices at which x goes from inactive to
    % active.
    %   stop is an array of indices at which x goes from active to
    % inactive.
    %
    % TOOLBOX DEPENDENCIES:
    %   none.
    
    start = (x(2:end) > 0) & (x(1:end-1) == 0);
    start = find([false;start]);
    stop = (x(2:end) == 0) & (x(1:end-1) > 0);
    stop = find([stop;false]);
    
end