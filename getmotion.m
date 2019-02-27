function motionData = getmotion(points)

% create s, which is an open serial connection to the arduino
    s=serial('/dev/cu.usbmodem1421');
    set(s,'BaudRate',115200)
    set(s,'Timeout',0.2)
    set(s,'DataBits',8)
    set(s,'StopBits',1)
    
% pre-allocate memory
    motionData=zeros(points,6);

% open the serial connection
    fopen(s);

% run a loop to get data
    for t=1:points,
        % send R to the arduino
        fprintf(s,'R');
        for tt=1:6,
            % read out data from the arduino
            motionData(t,tt)=fscanf(s,'%f');
            % fread is another option to fscanf
        end
        for tt=1:6
            % this made the project work before, but may not be necessary
            fscanf(s,'%f');
        end
    end

% close the serial connection
    fclose(s);
    
% plot all the data
    plot(motionData)
end