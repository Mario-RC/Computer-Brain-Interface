
function [mean_conv] = media_conv_pos(i,trial_data,idx,start,finish,gaussFilter)

suma = 0;

for j = idx'
    W = conv(trial_data(j).pos(:,1), gaussFilter, 'same');
    Z = conv(trial_data(j).pos(:,2)+30, gaussFilter, 'same');
    
    X = W(start(j):finish(j));
    Y = Z(start(j):finish(j));
    
    suma = suma + [X Y];
end
mean_conv = suma/length(idx);

t = (1:size(mean_conv,1))';
subtightplot(3,9,9+i)
plot(t,mean_conv(:,1),'LineWidth',2); hold on
plot(t,mean_conv(:,2),'LineWidth',2); hold on
plot([3 3], [-30 30], '--','color',[0.7 0.7 0.7],'LineWidth',1); hold off;
axis([0 24 -8 8])
axis off

end
