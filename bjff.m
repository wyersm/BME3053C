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