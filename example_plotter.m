
function example_plotter

    load('mcod_bout_data');
    sr = 20000;
    
    fish_id = 38;
    
    n = length(bout_data);
    
    for i = 1:n
        if bout_data(i).fish_id == fish_id
            break;
        end
    end
    i
    
    while bout_data(i).fish_id == fish_id
        bout_raw_plot(bout_data(i).praw, ...
                      bout_data(i).lraw, ...
                      bout_data(i).rraw, ...
                      bout_data(i).l, ...
                      bout_data(i).r, ...
                      bout_data(i).spikes, ...
                      sr);
        i = i + 1;
        pause;
    end
    
    
end