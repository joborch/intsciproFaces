%Working Directory setzen
currentFilePath = mfilename('fullpath');
[currentFolderPath, ~, ~] = fileparts(currentFilePath);
cd(currentFolderPath);

%% Definition der Gerätespezifika

myScreen = 0; %Define Screen

    white  = WhiteIndex(myScreen); %Color Index White
    black = BlackIndex(myScreen); %Color Index Black
    gray = (white+black)/2; %Color Index Gray

color = gray; %Definition of Color for myWindow

    [width, height]=Screen('WindowSize', 0); %Reads indivdual Screen Size
    ratioFactor = 0.75; %Factor for Screen: 1 is Fullscreen

ratio = [0 0 width*ratioFactor height*ratioFactor]; %Definition of Ratio for myWindow

%myWindow = Screen('OpenWindow', myScreen, color, ratio);

%% Einlesen der Bilder
picturePath = ('pictures\'); %define picture Path

cd(picturePath);

picFolder = dir(); %Save Picture Folder Contents

imgdata = cell(1:length(picFolder)-2);

for i = 3:length(picFolder)
    imgdata(i-2) = {imread(picFolder(i).name)};
end

cd(currentFolderPath);



% Experiment Abschluss
% KbWait; 
% Screen('CloseAll');