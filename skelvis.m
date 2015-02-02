% Luke Buschmann
% Virtual Rehabilitation User Study Range of Motion Measurements
readalldata = 1; % {0,1} set this to 1 to bypass rowstart and rowend for csvread
startparse = 620;  %{1 to maxrows} row to start at with readalldata=1
pausetime = 0.05; % pause time for each plot iteration. Decrease to speedup

user = 5; % {1,2,3,4,5} user number (1 through 5)
session = 1; % {0,1} 0 for initial/start session, 1 for end session

assert(readalldata == 0 || readalldata == 1, 'Invalid argument: readalldata {0,1}');
assert(startparse >= 1, 'Invalid argument: startparse must be >= 1');
assert(user == 1 || user == 2 || user == 3 || user == 4 || user == 5, 'Invalid argument: user {1,2,3,4,5}');
assert(session == 0 || session == 1, 'Invalid argument: session {0,1}');

test = (romnum-1)*8+1 + side*4 + session*2;
rowstart = csvinfo(user , (romnum-1)*8+1 + side*4 + session*2);
rowend = csvinfo(user , (romnum-1)*8+1 + side*4 + session*2 + 1);
if (session == 0)
    filename = strcat('User',num2str(user),'-ROM','start','.csv')
else
    filename = strcat('User',num2str(user),'-ROM','end','.csv')
end
if (readalldata == 1)
    
    rowstart = startparse;
    rowend = 0;
    data = csvread(filename,rowstart,1);
    % check data for ROM label. output the row.
else
    data = csvread(filename,rowstart,1, [ rowstart,1, rowend, 33]);
end

labelrows =  find(data(:,32)==99) ;
labelroms = data(labelrows,31);
labels = cat(2,labelrows+rowstart,labelroms)

% Read joint data from csv
xHead = data(:,1);
yHead = data(:,2);
zHead = data(:,3);

xNeck = data(:,4);
yNeck = data(:,5);
zNeck = data(:,6);


xRightShoulder = data(:,19);
yRightShoulder = data(:,20);  % right shoulder
zRightShoulder = data(:, 21);

xRightElbow = data(:,22);
yRightElbow = data(:,23);  % right elbow
zRightElbow = data(:,24);

xRightWrist = data(:,25);
yRightWrist = data(:,26); % right wrist
zRightWrist = data(:,27);

xLeftShoulder = data(:,7);
yLeftShoulder = data(:,8);  % left shoulder
zLeftShoulder = data(:,9);

xLeftElbow = data(:,10);
yLeftElbow = data(:,11);  % left elbow
zLeftElbow = data(:,12);

xLeftWrist = data(:,13);
yLeftWrist = data(:,14); % left wrist
zLeftWrist = data(:,15);



%// Plot point by point

close all
figure,hold on

view(26, 42)
for k = 1:numel(zNeck)  %(rowend - rowstart)
    title(strcat('user = ',num2str(user),' row= ',num2str(k+rowstart)));
    
    plot3([xHead(k) xNeck(k)], [yHead(k) yNeck(k)], [zHead(k) zNeck(k)])
    plot3([xRightShoulder(k) xNeck(k)], [yRightShoulder(k) yNeck(k)], [zRightShoulder(k) zNeck(k)])
    plot3([xLeftShoulder(k) xNeck(k)], [yLeftShoulder(k) yNeck(k)], [zLeftShoulder(k) zNeck(k)])
    plot3([xLeftShoulder(k) xLeftElbow(k)], [yLeftShoulder(k) yLeftElbow(k)], [zLeftShoulder(k) zLeftElbow(k)])
    plot3([xLeftWrist(k) xLeftElbow(k)], [yLeftWrist(k) yLeftElbow(k)], [zLeftWrist(k) zLeftElbow(k)])
    plot3([xRightShoulder(k) xRightElbow(k)], [yRightShoulder(k) yRightElbow(k)], [zRightShoulder(k) zRightElbow(k)])
    plot3([xRightWrist(k) xRightElbow(k)], [yRightWrist(k) yRightElbow(k)], [zRightWrist(k) zRightElbow(k)])
    text(xRightShoulder(k), yRightShoulder(k),zRightShoulder(k), 'RightShoulder');
    text(xRightElbow(k), yRightElbow(k), zRightElbow(k), 'RightElbow');
    text(xRightWrist(k),  yRightWrist(k),zRightWrist(k), 'RightWrist');
    text(xLeftShoulder(k), yLeftShoulder(k), zLeftShoulder(k), 'LeftShoulder');
    text(xLeftElbow(k), yLeftElbow(k), zLeftElbow(k), 'LeftElbow');
    text(xLeftWrist(k), yLeftWrist(k), zLeftWrist(k), 'LeftWrist');
    
    text(xHead(k), yHead(k), zHead(k), 'Head');
    text(xNeck(k), yNeck(k), zNeck(k), 'Neck');
    %         Rotate the view about the z-axis by 180º.
    
    
    %  view(3)  % default is az = –37.5, el = 30
    
    view (-12.5, 90) %(-12.5, 90) % view(0, 70) % view(az, el); % 180, 90
    pause(pausetime);
    clf;hold on;
end
