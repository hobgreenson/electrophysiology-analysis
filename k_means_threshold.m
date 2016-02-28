function [tl, tr, l_snr, r_snr] = k_means_threshold(template, l, r)
    
    n = length(l);
    if n ~= length(r)
        error('k_means_threshold: l and r must have equal length');
    end
  
    x = [l(:); r(:)];
    
    y = th(template, x);
     
    tl = y(1:n);
    tr = y((n+1):end);
    
    l_snr = abs(mean(l(tl > 0)) - mean(l(tl == 0)));
    r_snr = abs(mean(r(tr > 0)) - mean(r(tr == 0)));
    
end

function y = th(template, x)
    enchilada = [template; x];
    idx = kmeans(enchilada, 2, ...
                 'Options', statset('UseParallel', 1), ...
                 'Distance', 'cityblock', ...
                 'MaxIter', 1000, ...
                 'Replicates', 10);
    idx = idx(length(template)+1:end);
    m1 = mean(x(idx==1));
    m2 = mean(x(idx==2));
    y = zeros(size(x));
    if m1 < m2
        y(idx==2) = 5;
    else
        y(idx==1) = 5;
    end
end