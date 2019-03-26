function z = areaStats(p1, p2)
    
    x1  = (p1.scale^2)*mean(p1.areas);
    s1  = (p1.scale^2)*std(p1.areas);
    n1  = length(p1.areas);

    x2  = (p2.scale^2)*mean(p2.areas);
    s2  = (p2.scale^2)*std(p2.areas);
    n2  = length(p2.areas);
    
    % create a test stat
    z   = abs(x1 -x2) / sqrt((s1)^2/n1 + s2^2/n2);
end