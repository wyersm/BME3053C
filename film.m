function film(title)
set(gcf,'Position',[100 100 300 300])
g=getframe(gcf);
imwrite(g.cdata,['C:\frames\',title,'.jpg'],'jpg','Quality',50)

end