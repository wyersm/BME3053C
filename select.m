function [out,pos] = select(in)
figure, imagesc( log(in+0.001) ), colormap(gray)

pos=floor(ginput(2));

out = in(pos(1,2):pos(2,2),pos(1,1):pos(2,1),:);

out=double(out);

close
end