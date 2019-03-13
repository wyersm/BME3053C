function out = readImages(varargin)
    
    if nargin==0
        w       = dir; % look at the current directory
        n       = {w.name}; % get names of all files
        n(1:2)  = []; % get rid of first two values
    else
        n=varargin;
    end

    for t=1:length(n)
        fi(1)
 
        a = imread( n{t} ); % use cell array notation
        
        image(a)
        
        out(t).pic = a; % create structured variable containing images
        
        pause(0.02) 

    end
    
end
