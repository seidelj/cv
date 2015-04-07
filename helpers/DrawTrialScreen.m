function DrawTrialScreen( data, trial, exp_screen, window, response)

if (~exist('response', 'var'))
    response = false;
end

%DRAWTRIALSCREEN Summary of this function goes here
%   Detailed explanation goes here

blue = [0 0 1];
red = [1 0 0];
yellow = [1 1 0];
white = [1 1 1];

%determine frame color
if strcmp(data.trials(trial).condition, 'forced')
    frameColor = red;
elseif strcmp(data.trials(trial).condition, 'free')
    frameColor = blue;
else
    frameColor = yellow;
end


% for demo
theImageLocation = [PsychtoolboxRoot 'PsychDemos' filesep...
    'AlphaImageDemo' filesep 'konijntjes1024x768.jpg'];
theImage = imread(theImageLocation);

imageSize = size(theImage);

imageTexture = Screen('MakeTexture', exp_screen, theImage);

baseRect = [0 0 window.xPixels*.30 window.yPixels*.30];
baseFrame = [0 0 window.xPixels*.31 window.yPixels*.31];
textFrame = [0 0 window.xPixels*.0925 window.xPixels.*.05];
penWidthPixels = 10;

destinationRect = CenterRectOnPoint(baseRect,...
    window.xCenter, window.yCenter-window.yPixels*.3);
destinationFrame = CenterRectOnPoint(baseFrame,...
    window.xCenter, window.yCenter-window.yPixels*.3);

% The image
Screen('FrameRect', exp_screen, frameColor, destinationFrame, penWidthPixels);
Screen('DrawTexture', exp_screen, imageTexture,[],...
    destinationRect);

% The text
formatSpec = 'Pay $%d';
Screen('TextSize', exp_screen, 50);
DrawFormattedText(exp_screen, sprintf(formatSpec,data.trials(trial).amount), 'center',...
    window.yPixels*.45, white);
Screen('TextSize', exp_screen, 60);
DrawFormattedText(exp_screen, 'Yes', window.xPixels*.315,...
    window.yPixels*.55, white);
DrawFormattedText(exp_screen, 'No', window.xPixels*.625,...
    window.yPixels*.55, white);

% The frames
if response ~= false
    if response == data.keys.yesKey
        destinationTextFrame = CenterRectOnPoint(textFrame,...
            window.xPixels*.35, window.yPixels*.585);
    else
        destinationTextFrame = CenterRectOnPoint(textFrame,...
            window.xPixels*.65, window.yPixels*.585);
    end
    Screen('FrameRect', exp_screen, white, destinationTextFrame, 5);
end
end

