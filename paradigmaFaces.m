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
sizePicFolder = length(picFolder);

imgdata = cell(1:sizePicFolder-2);

for i = 3:sizePicFolder
    imgdata(i-2) = {imread(picFolder(i).name)};
end

cd(currentFolderPath);

%% Bilder zur Anzeige vorbereitem
r = randi([1 sizePicFolder-2]); %generate random number for picture display
fprintf('Zufallszahl ist %d.', 5); %Debug Message

%Save textures
textures = cell(1:sizePicFolder-2); %Define textures array
for i = 1:sizePicFolder-2
    textures(i) = {Screen('MakeTexture', myWindow, imgdata{i})}; %Save all imgdata as textures
end

fixCross = ones(50,50)*255;
fixCross(23:27,:) = 0;
fixCross(:,23:27) = 0;
fixcrossTexture = Screen('MakeTexture', myWindow, fixCross);

%% Experiments-Anzeige

texture = fixcrossTexture; %Defines used Texture
Screen('DrawTexture', myWindow, texture); %Draw Texture on Background
Screen('Flip', myWindow); %Show Texture
WaitSecs(3);
for i = 1:5
    Screen('FillRect', myWindow, black, ratio)
    Screen('Flip', myWindow);
    WaitSecs(1)
    Screen('FillRect', myWindow, white, ratio)
    Screen('Flip', myWindow);
    WaitSecs(1)
end
% showMask(1, 5, myWindow, ratio);
Screen('DrawTexture', myWindow, texture); %Draw Texture on Background
Screen('Flip', myWindow); %Show Texture



% Experiment Abschluss
KbWait; 
Screen('CloseAll');