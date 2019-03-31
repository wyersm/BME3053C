function zTest(pic, pic2)
    % inputs should be images in the local directory
    
    p.picture = imread(pic);
    p = cropPics(p);
    p = createMask(p);
    p = makeMeasurements(p);
    drawBounds(p);
  
    %Pop 1 Areas
    p1.areas = p.areas;
    
    p.picture = imread(pic2);
    p = cropPics(p);
    p = createMask(p);
    p = makeMeasurements(p);
    drawBounds(p);
    
    %Pop 2 Areas
    p2.areas = p.areas;
    
    %areaStats
    areaStats(p1.areas, p2.areas);
    
    %Stats
    %nhist(p.ecc, 10); title('Eccentricity')
    %nhist(p.areas, 10); title('Areas')
    %nhist(p.perim, 10); title('Perimeters')

end

function p = cropPics(p) % pics is now p

    for t = 1:length(p)

        % run the select code for color images
        p(t).cropped = select(p(t).picture);

    end

end

function p = createMask(p)
    
    for t=1:length(p)
        
        % we need to do better than this to get good measurements
        a = sum(double(p(t).cropped),3)/3; % greyscale
        m = mean(a(:)); 
        p(t).msk = a>125; % arbitrary threshold
        p(t).wshd = tryWatershed(p(t).msk);
        
    end

end

function out = tryWatershed(msk)

    d = -bwdist(~msk);
    d(~msk)=Inf;
    w = watershed(d);
    w(~msk)=0;
    out = w>0;
    %fi(out)
    
end

function p = makeMeasurements(p)

    for t=1:length(p)
        
        stats = regionprops(p(t).wshd,...
            'Centroid',...
            'Area',...
            'Perimeter',...
            'MajorAxisLength',...
            'MinorAxisLength',...
            'Eccentricity');
        
        cnt = [stats.Centroid];
        p(t).cnt = reshape(cnt,[2 numel(cnt)/2])';
        
        p(t).areas = [stats.Area];
        p(t).perim = [stats.Perimeter];
        
        p(t).majax = [stats.MajorAxisLength];
        p(t).minax = [stats.MinorAxisLength];
        
        p(t).ecc = [stats.Eccentricity];     
        
    end

end

function drawBounds(p)
    
    for t=1:numel(p)
        
        fi(p(t).cropped)
        
        dangerThreshold = 50;
        
        %Requirements to find dangerous nodules
        index1 = p.areas > dangerThreshold;
        index2 = p.areas < 350;
        index3= p.ecc > 0.70; %roundness
        index4 = p.perim > 35;
        index = index1 & index2 & index3 & index4;
        
        hold on
        
        xy = bwboundaries(p.wshd);
        
        for tt=1:numel(xy)
            allPoints = xy{tt};
            plot( allPoints(:,2), allPoints(:,1), 'b' )
        end
        plot( p(t).cnt(index,1), p(t).cnt(index,2), 'rx', 'Markersize', 25,'LineWidth', 2)
        
    end
    
end