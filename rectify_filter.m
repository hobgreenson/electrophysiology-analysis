function y = rectify_filter(x, sr, cut_off)
    [b, a] = butter(6, 2 * cut_off / sr);
    y = filtfilt(b, a, abs(x));
end