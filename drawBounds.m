function drawBounds(p)
    
    for t=1:numel(p)
        
        fi( p(t).cropped )
        
        hold on
        
        xy = bwboundaries(p.wshd);
        
        for tt=1:numel(xy)
            allPoints = xy{tt};
            plot( allPoints(:,2), allPoints(:,1), 'r' )
        end
        plot( p(t).cnt(:,1), p(t).cnt(:,2), 'blackx')
        
    end

end