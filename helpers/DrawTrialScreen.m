function DrawTrialScreen( data, exp_screen, screenRect, window, response)

if (~exist('response'))
    response = false;
end

%DRAWTRIALSCREEN Summary of this function goes here
%   Detailed explanation goes here

yellow = [1 1 0];

% for demo
theImageLocation = [PsychtoolboxRoot 'PsychDemos' filesep...
    'AlphaImageDemo' filesep 'konijntjes1024x768.jpg'];
theImage = imread(theImageLocation);

imageSize = size(theImage);

imageTexture = Screen('MakeTexture', exp_screen, theImage);

baseRect = [0 0 400 400];
baseFrame = [0 0 420 420];
penWidthPixels = 10;

destinationRect = CenterRectOnPoint(baseRect,...
    window.xCenter, window.yCenter-window.yPixels*.3);
destinationFrame = CenterRectOnPoint(baseFrame,...
    window.xCenter, window.yCenter-window.yPixels*.3);

Screen('FrameRect', exp_screen, yellow, destinationFrame, penWidthPixels);
Screen('DrawTexture', exp_screen, imageTexture,[],...
    destinationRect);
end

