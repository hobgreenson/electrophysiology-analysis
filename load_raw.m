function [x, sr] = load_raw(path)
    [~, si, ~] = abfload(path, 'info');
    dt = si * 1e-6;
    sr = 1 / dt;
    x = abfload(path);
end