function d = duty(x)
    % INPUT:
    %   x is assumed to be a square-wave; e.g. x > 0 when a ventral
    %   root is active and x == 0 when vental root is inactive.
    %
    % OUPUT:
    %   d is the duty; in other words, the fraction
    %   of elements x(i) of x such that x(i) > 0.
    %
    % TOOLBOX DEPENDENCIES:
    %   none.
    
    d = mean(x > 0);

end