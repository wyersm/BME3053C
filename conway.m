function conway
in=zeros(150);
set(gca,'Position',[0 0 1 1])
dir=[1 1;1 -1;-1 1;-1 -1];sw=1;
while 1
homemadepad
c=conv2(im,ones(3),'valid');
c=(in==1).*((c==3)+(c==4))+(in==0).*(c==3);
cc=conv2(c,[1 1 1],'same');
if sum(abs(in(:)-c(:)))<1200
    in=c;
    rw=[0 1 2]+randi(size(in,2));
    col=[0 1 2]+randi(size(in,1));
    in(col,rw)=[1 0 1;1 1 1;0 1 1];
    
else
    in=c+circshift(cc==3,[randi(3,1,2)-2]);
    sw=randi(4);
end
cm=min(9*sum(in(:))/numel(in),1);
imagesc(in-dt(in,3)),colormap([0 0 0;1-cm cm^3 cm])
pause(0.05)
dd=randi(2)*dir(sw,:)+[randi(3,1,2)-2];
in=circshift(in,dd);
end
function homemadepad
siz     = size(in);
im      = repmat(in,3,3);
start   = siz;
finish  = 2*siz+1;
im      = im(start(1):finish(1),start(2):finish(2));
end
end