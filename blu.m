cm=1-4*(1-pink).*pink.*gray;
cm=abs(cm-0.35);
cm=1-cm./max(cm(:));
colormap(circshift(cm(end:-1:1,:),[38 0]))