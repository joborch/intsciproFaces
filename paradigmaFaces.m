%Working Directory setzen
currentFilePath = mfilename('fullpath');
[currentFolderPath, ~, ~] = fileparts(currentFilePath);
cd(currentFolderPath);

%% Definition der Gerätespezifika

myScreen = 0; %Define Screen

    white  = WhiteIndex(myScreen); %Color Index White
    black = BlackIndex(myScreen); %Color Index Black
    gray = (white+black)/2; %Color Index Gray

color = white; %Definition of Color for myWindow

    [width, height]=Screen('WindowSize', 0); %Reads indivdual Screen Size
    ratioFactor = 0.75; %Factor for Screen: 1 is Fullscreen

ratio = [0 0 width*ratioFactor height*ratioFactor]; %Definition of Ratio for myWindow

myWindow = Screen('OpenWindow', myScreen, color, ratio);

%% Einlesen der Bilder
picturePath = ('pictures\'); %define picture Path

cd(picturePath);

picFolder = dir(); %Save Picture Folder Contents

imgdata = cell(length(picFolder)-2,1);
sizeimg = length(imgdata);
for i = 3:length(picFolder)
    disp(picFolder(i).name);
    imgdata(i-2) = {imread(picFolder(i).name)};
end

cd(currentFolderPath);

%% Bilder zur Anzeige vorbereitem
%Save textures
textures = cell(sizeimg,1); %Define textures array
for i = 1:sizeimg
    textures(i) = {Screen('MakeTexture', myWindow, imgdata{i})}; %Save all imgdata as textures
end

fixCross = ones(50,50)*255;
fixCross(23:27,:) = 0;
fixCross(:,23:27) = 0;
fixcrossTexture = Screen('MakeTexture', myWindow, fixCross);

%% Experiments-Anzeige

rt = zeros(sizeimg, 2);
KbCheck;
for i = 1:sizeimg
    % r = randi([1 sizeimg]); %generate random number for picture display
    % fprintf('Zufallszahl ist %d.', 5); %Debug Message

    Screen('DrawTexture', myWindow, fixcrossTexture); %Draw Texture on Background
    Screen('Flip', myWindow); %Show Texture
    WaitSecs(0.5);
    for j = 1:randi([5 15])
        Screen('FillRect', myWindow, black, ratio);
        Screen('Flip', myWindow);
        WaitSecs(.01);
        Screen('FillRect', myWindow, white, ratio);
        Screen('Flip', myWindow);
        WaitSecs(.01);
    end
    Screen('DrawTexture', myWindow, textures{i}); %Draw Texture on Background
    [~, onsetTime] = Screen('Flip', myWindow); %Show Texture and save Stimulus onset Time
      
    while 1
        [keyIsDown, secs, keyCode, deltaSecs] = KbCheck();
        rt(i,1) = secs-onsetTime;
        rt(i,2) = deltaSecs;
        if keyIsDown == 1
            break;
        elseif rt(i,1)>2
            rt(i,1) = 0;
            break;
        end
    end
    disp(rt(i));
end


% Experiment Abschluss
KbWait; 
Screen('CloseAll');