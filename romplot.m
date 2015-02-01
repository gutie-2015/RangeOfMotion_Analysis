% Luke Buschmann
% Virtual Rehabilitation User Study Range of Motion Measurements
readalldata = 1; % {0,1} set this to 1 to bypass rowstart and rowend for csvread
pausetime = 0.02; % pause time for each plot iteration. Decrease to speedup
readalldata = 0; pausetime = 0.02;
%readalldata = 1; pausetime = 0.01;
side = 1; % {0,1} 0 for left, 1 for right
user = 4; % {1,2,3,4,5} user number (1 through 5)
session = 1; % {0,1} 0 for initial/start session, 1 for end session
romnum = 4; % {1,2,3,4} range of motion measurement # (1 through 4)
showplot = 1; % {0,1}  0 disables plot and just shows statistics


test = (romnum-1)*8+1 + side*4 + session*2;
rowstart = csvinfo(user , (romnum-1)*8+1 + side*4 + session*2);
rowend = csvinfo(user , (romnum-1)*8+1 + side*4 + session*2 + 1);
if (session == 0)
    filename = strcat('User',num2str(user),'-ROM','start','.csv')
else
    filename = strcat('User',num2str(user),'-ROM','end','.csv')
end
   

if (readalldata == 1)
    data = csvread(filename,1,1);
    rowstart = 0;
    rowend = 0;
    % check data for ROM label. output the row.
else
    data = csvread(filename,rowstart,1, [ rowstart,1, rowend, 33]);
end

 labelrow = find(data(:,31)==romnum)+rowstart
%data(:,31)

% Read joint data from csv
xHead = data(:,1);
yHead = data(:,2);
zHead = data(:,3);

xNeck = data(:,4);
yNeck = data(:,5);
zNeck = data(:,6);

if side == 1 %strcmp('right',side)
    xShoulder = data(:,19);
    yShoulder = data(:,20);  % right shoulder
    zShoulder = data(:, 21);
  
    xElbow = data(:,22);
    yElbow = data(:,23);  % right elbow
    zElbow = data(:,24);
    
    xWrist = data(:,25);
    yWrist = data(:,26); % right wrist
    zWrist = data(:,27);
    else
    xShoulder = data(:,7);
    yShoulder = data(:,8);  % left shoulder
    zShoulder = data(:,9);
    
    xElbow = data(:,10);
    yElbow = data(:,11);  % left elbow
    zElbow = data(:,12);
    
    xWrist = data(:,13);
    yWrist = data(:,14); % left wrist
    zWrist = data(:,15);
end


%// Plot point by point
close all
figure,hold on

maxangle = 0;  % record maximum range of motion angle
%minangle = 180;
for k = 1:numel(zNeck)  %(rowend - rowstart)
    switch romnum
        case 1
            angle = atan2(yElbow(k) - yShoulder(k), zElbow(k) - zShoulder(k)); %atan2(y2-y1,x2-x1)
            angle = radtodeg(angle);
            if (angle > maxangle)
                maxangle = angle;
            end
            %{
    if (angle > maxangle && yElbow(k) > yShoulder(k))
        maxangle = angle;
    else
        if (angle < minangle && yElbow(k) < yShoulder(k))
            minangle = angle;
        end
    end
            %}
            
            if (showplot == 1)
                clf;hold on;
                plot([zHead(k) zNeck(k)], [yHead(k) yNeck(k)])
                plot([zNeck(k) zShoulder(k)], [ yNeck(k) yShoulder(k)])
                plot([zShoulder(k) zElbow(k)], [ yShoulder(k) yElbow(k)])
                plot(zNeck(k),yNeck(k),'b+')
                plot(zShoulder(k),yShoulder(k),'go')
                plot(zElbow(k),yElbow(k),'r*')
                str1 =  strcat('\leftarrow    ', num2str(angle));
                %  text(zNeck(k)+100, yNeck(k)+60,num2str(k));
                text(zShoulder(k)+30, yShoulder(k)+30, str1);
                title(strcat('row= ',num2str(k+rowstart)));
                if side == 1 %strcmp('right',side)
                    text(zShoulder(k), yShoulder(k), 'RightShoulder');
                    text(zElbow(k), yElbow(k), 'RightElbow');
                else
                    text(zShoulder(k), yShoulder(k), 'LeftShoulder');
                    text(zElbow(k), yElbow(k), 'LeftElbow');
                end
                text(zHead(k), yHead(k), 'Head');
                text(zNeck(k), yNeck(k), 'Neck');
                pause(pausetime);
                
            end
            
        case 2
            angle = atan2(yElbow(k) - yShoulder(k), xElbow(k) - xShoulder(k)); %atan2(y2-y1,x2-x1)
            angle = radtodeg(angle);
            if (angle > maxangle && side ==1)
                maxangle = angle;
            else 
                if (angle < maxangle && side == 0)
                    maxangle=angle;
                end
            end
            
            if (showplot == 1)
                clf;hold on;
                plot([xHead(k) xNeck(k)], [yHead(k) yNeck(k)])
                plot([xNeck(k) xShoulder(k)], [ yNeck(k) yShoulder(k)])
                plot([xShoulder(k) xElbow(k)], [ yShoulder(k) yElbow(k)])
                plot(xNeck(k),yNeck(k),'b+')
                plot(xShoulder(k),yShoulder(k),'go')
                plot(xElbow(k),yElbow(k),'r*')
                str1 =  strcat('\leftarrow    ', num2str(angle));
                %  text(zNeck(k)+100, yNeck(k)+60,num2str(k));
                text(xShoulder(k)+30, yShoulder(k)+30, str1);
                title(strcat('row= ',num2str(k+rowstart)));
                if side == 1 %strcmp('right',side)
                    text(xShoulder(k), yShoulder(k), 'RightShoulder');
                    text(xElbow(k), yElbow(k), 'RightElbow');
                else
                    text(xShoulder(k), yShoulder(k), 'LeftShoulder');
                    text(xElbow(k), yElbow(k), 'LeftElbow');
                end
                text(xHead(k), yHead(k), 'Head');
                text(xNeck(k), yNeck(k), 'Neck');
                pause(pausetime);
                
            end
            
        case 3
            angle = atan2(zElbow(k) - zShoulder(k), xElbow(k) - xShoulder(k)); %atan2(y2-y1,x2-x1)
            angle = radtodeg(angle);
            if (angle < maxangle && side == 1)
                maxangle = angle;
            else 
                if (angle > maxangle && side == 0)
                    maxangle=angle;
                end
            end
            
            if (showplot == 1)
                clf;hold on;
                plot([xHead(k) xNeck(k)], [zHead(k) zNeck(k)])
                plot([xNeck(k) xShoulder(k)], [ zNeck(k) zShoulder(k)])
                plot([xShoulder(k) xElbow(k)], [ zShoulder(k) zElbow(k)])
                plot(xNeck(k),zNeck(k),'b+')
                plot(xShoulder(k),zShoulder(k),'go')
                plot(xElbow(k),zElbow(k),'r*')
                str1 =  strcat('\leftarrow angle= ', num2str(angle));
                %  text(zNeck(k)+100, yNeck(k)+60,num2str(k));
                text(xShoulder(k)+30, zShoulder(k)+30, str1);
                title(strcat('row= ',num2str(k+rowstart)));
                if side == 1 %strcmp('right',side)
                    text(xShoulder(k), zShoulder(k), 'RightShoulder');
                    text(xElbow(k), zElbow(k), 'RightElbow');
                else
                    text(xShoulder(k), zShoulder(k), 'LeftShoulder');
                    text(xElbow(k), zElbow(k), 'LeftElbow');
                end
                text(xHead(k), zHead(k), 'Head');
                text(xNeck(k), zNeck(k), 'Neck');
                pause(pausetime);
                
            end
            
        case 4
            angle = atan2(zWrist(k) - zElbow(k), xWrist(k) - xElbow(k)); %atan2(y2-y1,x2-x1)
            angle = radtodeg(angle);
            if (angle < maxangle && side == 1)
                maxangle = angle;
            else 
                if (angle > maxangle && side == 0)
                    maxangle=angle;
                end
            end
            
            if (showplot == 1)
                clf;hold on;
                plot([xHead(k) xNeck(k)], [zHead(k) zNeck(k)])
                plot([xNeck(k) xShoulder(k)], [ zNeck(k) zShoulder(k)])
                plot([xShoulder(k) xElbow(k)], [ zShoulder(k) zElbow(k)])
                plot([xElbow(k) xWrist(k)], [zElbow(k) zWrist(k)])
                plot(xWrist(k),zWrist(k),'-')
                plot(xNeck(k),zNeck(k),'b+')
                plot(xShoulder(k),zShoulder(k),'go')
                plot(xElbow(k),zElbow(k),'r*')
                str1 =  strcat('\leftarrow angle= ', num2str(angle));
                %  text(zNeck(k)+100, yNeck(k)+60,num2str(k));
                text(xElbow(k)+30, zElbow(k)+30, str1);
                title(strcat('row= ',num2str(k+rowstart)));
                if side == 1 %strcmp('right',side)
                    text(xShoulder(k), zShoulder(k), 'RightShoulder');
                    text(xElbow(k), zElbow(k), 'RightElbow');
                    text(xWrist(k), zWrist(k), 'RightWrist');
                else
                    text(xShoulder(k), zShoulder(k), 'LeftShoulder');
                    text(xElbow(k), zElbow(k), 'LeftElbow');
                    text(xWrist(k), zWrist(k), 'LeftWrist');
                end
                text(xHead(k), zHead(k), 'Head');
                text(xNeck(k), zNeck(k), 'Neck');
                pause(pausetime);
                
            end
            
        otherwise
            error('ROM number invalid. Use 1 through 4');
    end
end
%if (maxangle == 0) minangle
%else maxangle
%end
maxangle




%a=1;
%{
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
%}


%data = csvread('User4-ROMstart.csv',380,2, [ 380,2, 410, 32]); % 1 right
%data = csvread('User4-ROMstart.csv',260,2, [ 260,2, 370, 32]); % 1 left
%data = csvread('User4-ROMend.csv',80,1, [80,1, 150, 32]);  % 1 right
%data = csvread('User4-ROMend.csv',120,1, [120,1, 200, 32]);  % 1 left





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