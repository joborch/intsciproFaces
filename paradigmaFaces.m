%Working Directory setzen
currentFilePath = mfilename('fullpath'); %speichern vom Pfad der genutzten Datei
[currentFolderPath, ~, ~] = fileparts(currentFilePath); %rausspeichern vom Ordner-Pfad 
cd(currentFolderPath); %Aktuelles Working Directory setzen!

%% Definition der Gerätespezifika

myScreen = 1; %Define Screen

    white  = WhiteIndex(myScreen); %Color Index White
    black = BlackIndex(myScreen); %Color Index Black
    gray = (white+black)/2; %Color Index Gray

color = white; %Definition of Color for myWindow

    [width, height] = Screen('WindowSize', myScreen); %Reads indivdual Screen Size
    ratioFactor = 0.75; %Factor for Screen: 1 is Fullscreen

ratio = [0 0 width*ratioFactor height*ratioFactor]; %Definition of Ratio for myWindow

myWindow = Screen('OpenWindow', myScreen, color, ratio);

%% Einlesen der Bilder
picturePath = ('pictures\'); %define picture Path

cd(picturePath); %ändern des Working Directory zum einfacheren Zugriff auf die Bilder

picFolder = dir(); %Save Picture Folder Contents

imgdata = cell(length(picFolder)-2,1); %create imgdata as a cell of the length of picfolder-2 (2 Windows files)
sizeimg = length(imgdata); %länge von imgdata. 
for i = 3:length(picFolder) %einlesen aller Bilder in picFolder
    disp(picFolder(i).name); %Ausgabe des eingelesenen Namens
    imgdata(i-2) = {imread(picFolder(i).name)}; %einlesen der Bilder in Array imgdata
end %Ende Bilder Einlesen

cd(currentFolderPath); %Zurückändern des Working Directory auf Grundpfad 

%% Bilder zur Anzeige vorbereitem
%Save textures
textures = cell(sizeimg,1); %Define textures array
for i = 1:sizeimg %alle imgdata Bilder als Textur einspeichern
    textures(i) = {Screen('MakeTexture', myWindow, imgdata{i})}; %Save all imgdata as textures
end

%Fixationskreuz erstellen.
fixCross = ones(50,50)*255;
fixCross(23:27,:) = 0;
fixCross(:,23:27) = 0;
fixcrossTexture = Screen('MakeTexture', myWindow, fixCross); %Textur für Fixationskreuz definieren

%% Experiments-Anzeige

n = 2; %Menge an Anzeigen
fprintf('Experiment mit %d Bildern starten ', n)
rt = zeros(n, 2);
fprintf('Reaktionszeiten initialisiert. ')
kc = strings(n,1);
fprintf('Keycodes initialisiert. ')
KbCheck; %Referenz KbCheck zur Befehlsini
fprintf('KbCheck initialisiert. ')
for i = 1:n
    Screen('FillRect', myWindow, white, ratio); %Bildschirm weißeln
    Screen('DrawTexture', myWindow, fixcrossTexture); %Fixationskreuz vorbereiten
    fprintf('Fixationskreuz initialisiert. ')
    Screen('Flip', myWindow); %Fixationskreuz zeigen 
    WaitSecs(1); %eine Sekunde warten
    Screen('FillRect', myWindow, black, ratio); %schwarze Maske vorbereiten
    fprintf('Maske initialisiert. ') 
    Screen('Flip', myWindow); %Maske anzeigen
    WaitSecs(randi([1 4])); %Zeit zwischen 1 und 4 Sekunden warten
    t = randi([1 sizeimg]); %Zufälliges Gesicht auswählen
    fprintf('Bild #%d ausgewählt. ', t);
    Screen('DrawTexture', myWindow, textures{t}); %zufälliges Gesicht aus Ordner anzeigen
    fprintf('Bild #%d initialisiert. ', t)

    %Reaktionszeitmessung    
    [~, onsetTime] = Screen('Flip', myWindow); %Show Texture and save Stimulus onset Time
      
    while 1 %Ewige Schleife die mit Break beendet wird
        [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(); %Speichern aller KbCheck Parameter
        rt(i,1) = secs-onsetTime; %Reaktionszeit berechnung
        rt(i,2) = deltaSecs; %Zusatzdaten zum Abschätzen von Delays
        if keyIsDown == 1
            kc(i,1) = KbName(keyCode);
            break; %Stopp bei Keypress
        elseif rt(i,1)>2 %Abbruch nach 2 Sekunden
            rt(i,1) = 0;
            break;
        end
    end
    fprintf('! - Reaktionszeit %d.', rt(i));
    fprintf(' - KeyCode %s.', kc(i));
end
Screen('Close');
Screen('FillRect', myWindow, white, ratio); %Bildschirm weißeln
Screen('DrawText', myWindow, 'Danke für die Teilnahme!', 100, 100);
Screen('Flip', myWindow);

%% Experiment Abschluss
KbWait; 
Screen('CloseAll');