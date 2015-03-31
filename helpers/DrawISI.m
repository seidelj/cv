function DrawISI( exp_screen, screenRect )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

white = WhiteIndex(exp_screen);

[xCenter, yCenter] = RectCenter(screenRect);

fixCrossDimPix = 40;

xCoords = [ -fixCrossDimPix fixCrossDimPix 0 0];
yCoords = [0 0 -fixCrossDimPix fixCrossDimPix];
allCoords = [xCoords; yCoords];

lineWidthPix = 6;
Screen('DrawLines', exp_screen, allCoords,...
    lineWidthPix, white, [xCenter yCenter], 2);



end

