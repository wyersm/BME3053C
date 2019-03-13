function pics = fixThis(varargin)
    % Here is some code that you will need to fix today.
    % As you hit errors, track down the cause and make changes.

    % Type this in the console: fixThis('hand.JPG','seeds.JPG','dollar.JPG')

    % first load up images
    % output a structured variable that contains them
    pics = readImages(varargin{:});

    close all
    % zoom in on objects of interest
    pics = cropPics(pics);

    %segment the cropped images using color theory
    pics = createMask(pics);


end

function p = cropPics(p)

    for t = 1:length(p)

        % run the select code for color images
        p(t).cropped = select(p(t).pic);

    end

end

function p = createMask(p) %pics is now p...
    
    for t=1:length(p)
        
        fi(1)
        prettyColors(p(t).cropped)
        
        a = sum(double(p(t).cropped),3)/3; %grayscale
        m = mean(a(:));
        p(t).msk = a>125; %arbitrary threshold
        tryWatershed(p(t).msk)
        
        %nhist(a(:),25)
    end

end

%fi(imerode(p.msk,ones(11)))

function tryWatershed(msk)

    d = -bwdist(~msk);
    d(~msk)=Inf;
    w = watershed(d);
    w(~msk)=0;
    fi(w>0)

end

function prettyColors(in)

    siz = size(in);
    
    if siz(1) > 100
        step = 10*round(siz(1)/100);
    else
        step = 10;
    end
    
    % separate out all the color channels
    r = double(in(1:step:end, 1:step:end, 1)); %red color channel
    g = double(in(1:step:end, 1:step:end, 2)); %green
    b = double(in(1:step:end, 1:step:end, 3)); %blue
    
        
    subplot(1,2,1)
    image(uint8(in)),axis off
     
    subplot(1,2,2)
    plot3(0,0,0,'.black')
    hold on
     
    for t=1:numel(r);
        plot3(r(t),g(t),b(t),'o',...
             'MarkerFaceColor',[r(t) g(t) b(t)]/255,... %divide by 255 to scale values to 1
             'MarkerEdgeColor','none')
        pause(0.02)
    end
    
    
end