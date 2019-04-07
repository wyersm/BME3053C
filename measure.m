function [objMajax, meanObj, stdObj] = measure(pic)
    clc;
    
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
    
    nhist(pixMajax, 10); title('Major Axis/Diameter Distribution')
    
    limit = input('Enter minimum value for major axis: '); %A good estimation from histogram
    
    %Delete objects that are for sure not seeds/some other object
    for t = length(pixMajax):-1:1
        if pixMajax(t) < limit %limit on what major axis measurements will be considered
            pixMajax(t) = [];
        end
    end
    
    %%Find MEAN & STD from object array
    %objMajax = .00256.*pixMajax; %--> conversion for seeds
    %objMajax = .006800408*pixMajax; %--> conversion for M&Ms Take 1
    objMajax = .005800408*pixMajax; %--> conversion for M&Ms Take 2
    meanObj = mean(objMajax(:));
    stdObj = std(objMajax(:));
    
    nhist(objMajax, 10); title('Major Axis Distribution (Inches) After Limitation')

    fprintf('The major axis mean of the objects is: %4.4f inches \n', meanObj);
    fprintf('The major axis standard deviation of the objects is: %4.4f inches \n', stdObj);
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
        p(t).msk = a>55; % arbitrary threshold
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