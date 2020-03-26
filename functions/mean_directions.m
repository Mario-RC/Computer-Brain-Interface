
function [media] = media_direcciones(idx,trial_data,start,finish)

suma = 0;
for i = idx'
    suma = suma + trial_data(i).M1_spikes(start(i):finish(i),:);
end

media = suma/length(idx);

end
