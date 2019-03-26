function pics = improveThis(varargin)
    % inputs should be images in the local directory

    % first load up images
    % output a structured variable that contains them
    pics = readImages(varargin{:});
    
    pics = downsampleImage(pics, 2);

    % zoom in on objects of interest
    pics = cropPics(pics);

    % segment the cropped images using color theory
    pics = createMask(pics);
    
    % make some measurements of the selected objects
    pics = makeMeasurements(pics);

end

function p = downsampleImage(p,skip)

    for t=1:numel(p)
        p(t).pic = p(t).pic(1:skip:end,1:skip:end,:);
        p(t).scale = skip;
    end

end

function p = cropPics(p) % pics is now p

    for t = 1:length(p)

        % run the select code for color images
        p(t).cropped = select(p(t).pic);

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