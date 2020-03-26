
function media_conv_pos_relativa(i, mean_conv)

subtightplot(3,9,18+i)
plot(mean_conv(:,1),mean_conv(:,2),'LineWidth',2); hold on
plot([0 0], [-30 30], '--','color',[0.7 0.7 0.7],'LineWidth',1); hold on;
plot([-30 30], [0 0], '--','color',[0.7 0.7 0.7],'LineWidth',1); hold off;
axis([-8 8 -8 8])
axis off

end
