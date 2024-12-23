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
picturePath = ('pictures\'); %define picture Path

pics = dir(picturePath);





% %% Einlesen der Bilder
% path = pictures; %define Path


% % Get a list of all image files in the folder
% imageFiles = dir(fullfile(folderPath, '*.*')); % Match all file types
% imageExtensions = {'.jpg', '.png', '.jpeg', '.bmp', '.tiff', '.gif'}; % Supported extensions

% % Loop through each file
% for k = 1:length(imageFiles)
%     [~, ~, ext] = fileparts(imageFiles(k).name); % Get the file extension
%     if ismember(lower(ext), imageExtensions) % Check if the file is an image
%         % Read the image
%         imagePath = fullfile(folderPath, imageFiles(k).name);
%         img = imread(imagePath);
        
%         % Display the image (optional)
%         figure, imshow(img), title(['Image: ', imageFiles(k).name]);
        
%         % (Optional) Perform operations on the image here
%         disp(['Processed image: ', imageFiles(k).name]);
%     end
% end



% Experiment Abschluss
% KbWait; 
% Screen('CloseAll');