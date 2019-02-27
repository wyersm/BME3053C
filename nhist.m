function nhist(in,bins)

[q1,q2]=hist(in,bins);

figure,bar(q2,q1/sum(q1)),bjff

set(gca,'position',[0.15 0.15 0.78 0.78]);

end