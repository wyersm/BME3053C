function [meanObj, stdObj] = measure(pic)

    % inputs should be images in the local directory
    
    p.picture = imread(pic);
    
    % zoom in on objects of interest
    p = cropPics(p);

    % segment the cropped images using color theory
    p = createMask(p);
    
    % make some measurements of the selected objects
    p = makeMeasurements(p);
    
    %Find major axis of all objects from makeMeasurements function
    pixMajax = p.majax;
    objMajax = .00256.*pixMajax;
    meanObj = mean(objMajax(:));
    stdObj = std(objMajax(:));
   
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
        p(t).msk = a>150; % arbitrary threshold
        p(t).wshd = tryWatershed(p(t).msk);
        
    end

end

function out = tryWatershed(msk)

    d = -bwdist(~msk);
    d(~msk)=Inf;
    w = watershed(d);
    w(~msk)=0;
    out = w>0;
    fi(out)
    
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