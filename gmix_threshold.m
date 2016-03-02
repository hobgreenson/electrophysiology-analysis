
function [tl, tr] = gmix_threshold(template, l, r)

    x = [template; l; r];
    
    mdl = fitgmdist(x, 2, ...
                    'Options', statset('MaxIter', 1000), ...
                    'Replicates', 10);
    idx = cluster(mdl, x);
    
    x = x((length(template) + 1):end);
    idx = idx((length(template) + 1):end);
    
    m1 = mean(x(idx==1));
    m2 = mean(x(idx==2));
    y = zeros(size(x));
    if m1 < m2
        y(idx==2) = 5;
    else
        y(idx==1) = 5;
    end
    
    tl = y(1:length(l));
    tr = y((length(l) + 1):end);
end