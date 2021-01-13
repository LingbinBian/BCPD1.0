function[]=visual_labels(labels,K_min)
% This function visulizes the latent labels.
    imagesc(labels)    
    xlabel('Labels','fontsize',16)
    ylabel('Node number','fontsize',16)
    % colormap(parula(max(K_min)));
    colormap(lines(max(K_min)));
    colorbar_community(max(K_min))
    set(gca,'xtick',[])
    set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
end