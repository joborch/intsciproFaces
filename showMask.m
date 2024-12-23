function [white] = showMask(time, duration, WindowPtr, size)
%UNTITLED Shows a black/white jittered Mask
%   For a defined time a Square is shown that changes between Black and white

white = WhiteIndex(WindowPtr);
black = WhiteIndex(WindowPtr);

for i = 1:duration
    Screen('FillRect', WindowPtr, black, size);
    Screen('Flip', WindowPtr);
    WaitSecs(time)
    Screen('FillRect', WindowPtr, white, size);
    Screen('Flip', WindowPtr);
    WaitSecs(time)
end

end