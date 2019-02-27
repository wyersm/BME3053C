function ff(a)

    figure, imagesc(a), axis off
    set(gcf,'position',[2*96 2*96 4*96 4*96]);            
    set(gca,'position',[0 0 1 1]);
    colormap((gray/8+0.875).*bone.^0.8)
    
end

function bjff
dpi=96; 
hxl=get(gca,'xlabel');
hyl=get(gca,'ylabel');
box off
grid off

set(hyl,'fontweight','bold','fontsize',18);
set(hxl,'fontweight','bold','fontsize',18);

set(gca,'linewidth',1.5,'fontweight','normal','fontsize',18);
set(gca,'ticklength',[0.03 0.025]);
set(gca,'position',[0.12 0.15 0.78 0.78]);
f=findobj('linewidth',0.5);
set(f,'linewidth',2)

set(gcf,'position',[300 300 4.58*dpi dpi*4.58/1.33]);
set(gcf,'color',[1 1 1]);
set(gca,'tickdir','out');
end

function nhist(in,bins)
[q1,q2]=hist(in,bins);
figure,bar(q2,q1/sum(q1)),bjff
set(gca,'position',[0.15 0.15 0.78 0.78]);
end

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