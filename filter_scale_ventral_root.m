function x = filter_scale_ventral_root(x, sr)
    [b, a] = butter(10, 2 * [300, 3000] / sr, 'bandpass');
    x = filtfilt(b, a, x);
    n = round(length(x) * 0.8);
    [~, idx] = sort(abs(x));
    ax = x(idx);
    m = mean(ax(1:n));
    s = std(ax(1:n));
    x = (x - m) / s;
end 