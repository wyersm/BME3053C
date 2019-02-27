function fi(a)
figure,imagesc(a),axis off
%     colormap(jet.*(gray.^0.2))
%     set(gca,'position',[0.1 0.1 0.8 0.8]);
    set(gca,'position',[0 0 1 1]);
    set(gcf,'position',[2*96 2*96 4*96 4*96]);
    colormap((gray/8+0.875).*bone.^0.8)
%       cm=((gray/8+0.875).*bone.^0.8);
%       cm=1-4*(1-pink).*pink.*gray;
%       cm=abs(cm-0.35);
%       cm=1-cm./max(cm(:));
%       colormap(circshift(cm(end:-1:1,:),[18 0]))
%       colormap(1-4*(1-pink).*pink)
end