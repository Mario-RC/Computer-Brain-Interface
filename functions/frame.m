
function [start,finish] = marco(trial_data)

% Mínimo tiempo entre go cue y final
maxbin = inf;
minbin = inf;

% Hallamos la repetición más rápida (13) que tarda sólo 20 bins
for i = 1:size(trial_data,2)
    
    val_min = trial_data(i).idx_trial_end - trial_data(i).idx_go_cue;
    if val_min < minbin
        minbin = val_min;
    end
    
    val_max = trial_data(i).idx_go_cue - trial_data(i).idx_trial_start;
    if val_max < maxbin
        maxbin = val_max;
    end
    
end

start = [trial_data.idx_go_cue]' - maxbin;
finish = [trial_data.idx_go_cue]' + minbin;

end
