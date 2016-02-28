
function f = frequency(start, stop, sr)
    % INPUT:
    %   start is a squence of indices demarcating the start of events;
    %   stop is a squence of indices demarcating the termination of events;
    %   sr is the sample rate.
    % For example, start and stop can mark the indices at which locomotor
    % cycles begin and end. 
    %
    % OUPUT:
    %   f is the frequency (Hz) corresponding to each start-stop pair.
    %
    % TOOLBOX DEPENDENCIES:
    %   none.
    
    if length(start) ~= length(stop)
        error('frequency: length(start) must be equal to length(stop)');
    end
    
    t = stop - start;
    
    if any(t <= 0)
        error('frequency: interval between stop and start was zero or negative');
    end
    
    f = sr ./ t;
    
end