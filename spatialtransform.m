function spatialtransform(I)
f = @(x) complex(x(:,1),x(:,2));
g = @(z) ((z-1).*(z+1).*(z+.1-2*i).*(z+1+2*i)) ./ ...
    (power(z+1+i,4)+power(z-1-i,4));
h = @(w) [real(w) imag(w)];
q = @(x,unused) h(g(g(g(g(f(x))))));
tform = maketform('custom', 2, 2, [], q, []);
J=imtransform(I, tform, 'UData', [-1.5 1.5], 'VData', [-1.5 1.5], ...
    'XData', [0 6], 'YData', [-4 2], 'FillValues', [10 15 20]');
imshow(J)
end