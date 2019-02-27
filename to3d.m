function to3d(im)
figure
p=surf(im);
axis off
set(gcf,'color','none')
set(p,'facecolor','none')
hold on
y=min(im(:))-1.5*mean(im(:));
p=surf(y*ones(size(im)));
set(p,'Cdata',im,'linestyle','none')

colormap((gray/8+0.875).*bone.^0.8)
set(gca,'position',[-0.05 0 1 1.2])
set(gca,'View',[-27.5 18])
set(gcf,'color',[1 1 1])
end