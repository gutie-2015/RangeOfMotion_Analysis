% Luke Buschmann
% Virtual Rehabilitation User Study Range of Motion Measurements
side = 'right'; % 'right'; % 'left';
user = 2;
session = 'end';  % 'start';  % 'end';
pausetime = 0.05;

switch user
    case 1
        if strcmp('start',session)
            if (strcmp('right',side))
                rowstart = 250;
                rowend = 320;
            else % left side
                error('User 1 did not use left side');
            end
        else % end sessions
            if (strcmp('right',side))
                rowstart = 250;
                rowend = 330;
            else % left side
                error('User 1 did not use left side');
            end
        end
    case 2
        if strcmp('start',session)
            if (strcmp('right',side))
                rowstart = 1;
                rowend = 500;
            else % left side
                rowstart = 1;
                rowend = 500;
            end
        else % end sessions
            if (strcmp('right',side))
                rowstart = 100;
                rowend = 400;
            else % left side
                rowstart = 1;
                rowend = 500;
            end
        end
    case 3
        if strcmp('start',session)
            if (strcmp('right',side))
                rowstart = 1;
                rowend = 500;
            else % left side
                rowstart = 1;
                rowend = 500;
            end
        else % end sessions
            if (strcmp('right',side))
                rowstart = 1;
                rowend = 500;
            else % left side
                rowstart = 1;
                rowend = 500;
            end
        end
    case 4
        if strcmp('start',session)
            if (strcmp('right',side))
                rowstart = 380;
                rowend = 410;
            else % left side
                rowstart = 260;
                rowend = 370;
            end
        else % end sessions
            if (strcmp('right',side))
                rowstart = 80;
                rowend = 150;
            else % left side
                rowstart = 120;
                rowend = 200;
            end
        end
    case 5
        if strcmp('start',session)
            if (strcmp('right',side))
                rowstart = 1;
                rowend = 500;
            else % left side
                rowstart = 1;
                rowend = 500;
            end
        else % end sessions
            if (strcmp('right',side))
                rowstart = 1;
                rowend = 500;
            else % left side
                rowstart = 1;
                rowend = 500;
            end
        end
        
end
filename = strcat('User',num2str(user),'-ROM',session,'.csv');
data = csvread(filename,rowstart,1, [ rowstart,1, rowend, 32]);

%data = csvread('User4-ROMstart.csv',380,2, [ 380,2, 410, 32]); % 1 right
%data = csvread('User4-ROMstart.csv',260,2, [ 260,2, 370, 32]); % 1 left
%data = csvread('User4-ROMend.csv',80,1, [80,1, 150, 32]);  % 1 right
%data = csvread('User4-ROMend.csv',120,1, [120,1, 200, 32]);  % 1 left


zHead = data(:,3);
yHead = data(:,2);

zNeck = data(:,6);
yNeck = data(:,5);
if strcmp('right',side)
    zShoulder = data(:, 21);
    yShoulder = data(:,20);  % right shoulder
    
    zElbow = data(:,24);
    yElbow = data(:,23);  % right elbow
else
    zShoulder = data(:, 9);
    yShoulder = data(:,8);  % left shoulder
    
    zElbow = data(:,12);
    yElbow = data(:,11);  % left elbow
    
end
close all
%// Plot starts here
figure,hold on

%// Set x and y limits of the plot
%xlim([min(x(:)) max(x(:))])
%xlim([min(x(:)) max(x(:))])
%ylim([min(y(:)) max(y(:))])

%// Plot point by point
for k = 1:numel(zNeck)
    %   plot(x(k),y(k),'-') %// Choose your own marker here
    clf;hold on;
    plot([zHead(k) zNeck(k)], [yHead(k) yNeck(k)])
    plot([zNeck(k) zShoulder(k)], [ yNeck(k) yShoulder(k)])
    plot([zShoulder(k) zElbow(k)], [ yShoulder(k) yElbow(k)])
    plot(zNeck(k),yNeck(k),'b+')
    plot(zShoulder(k),yShoulder(k),'go')
    plot(zElbow(k),yElbow(k),'r*')
    angle = atan2(yElbow(k) - yShoulder(k), zElbow(k) - zShoulder(k)); %atan2(y2-y1,x2-x1)
    angle = radtodeg(angle);
    str1 =  strcat('\leftarrow    ', num2str(angle));
    text(zNeck(k)+100, yNeck(k)+60,num2str(k));
    text(zShoulder(k)+30, yShoulder(k)+30, str1);
    if strcmp('right',side)
        text(zShoulder(k), yShoulder(k), 'RightShoulder');
        text(zElbow(k), yElbow(k), 'RightElbow');
    else
        text(zShoulder(k), yShoulder(k), 'LeftShoulder');
        text(zElbow(k), yElbow(k), 'LeftElbow');
    end
    text(zHead(k), yHead(k), 'Head');
    text(zNeck(k), yNeck(k), 'Neck');
    % angle = atan2(abs(det([v1,v2])),dot(v1,v2));
    % str1 = '\leftarrow sin(\pi) = 0';
    %text(x1,y1,str1)
    %// MATLAB pauses for 0.001 sec before moving on to execue the next
    %%// instruction and thus creating animation effect
    %pause(0.1);
    pause(pausetime);
    %   pause (0.7);
    
end


%/
% h = plot(NaN,NaN); %// initiallize plot. Get a handle to graphic object
% axis([min(DATASET1) max(DATASET1) min(DATASET2) max(DATASET2)]); %// freeze axes
% %// to their final size, to prevent Matlab from rescaling them dynamically
% for ii = 1:length(DATASET1)
%     pause(0.01)
%     set(h, 'XData', DATASET1(1:ii), 'YData', DATASET2(1:ii));
%     drawnow %// you can probably remove this line, as pause already calls drawnow
% end
%