function [out,pos] = select(in)
figure, image(in), colormap(gray)

pos=floor(ginput(2));

out = in(pos(1,2):pos(2,2),pos(1,1):pos(2,1),:);

out=double(out);

close
end