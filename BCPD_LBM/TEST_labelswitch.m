% Test label switching


label_v=zeros(10,5);

label_v(:,1)=[2 2 3 3 1 1 1 2 1 3]';
label_v(:,2)=[3 3 1 1 2 2 2 3 2 1]';
label_v(:,3)=[3 3 4 2 1 1 1 3 1 2]';
label_v(:,4)=[2 2 3 3 1 1 1 2 1 3]';
label_v(:,5)=[1 1 3 3 2 2 2 1 2 3]';

figure
imagesc(label_v)
title('label_v','fontsize',16) 
xlabel('Iteration','fontsize',14)
ylabel('Latent labels','fontsize',14)
colormap(parula(max(max(label_v))));
colorbar_community(max(max(label_v)));


label_update=labelswitch(label_v);

figure
imagesc(label_update)
title('label_v','fontsize',16) 
xlabel('Iteration','fontsize',14)
ylabel('Latent labels','fontsize',14)
colormap(parula(max(max(label_update))));
colorbar_community(max(max(label_update)));





