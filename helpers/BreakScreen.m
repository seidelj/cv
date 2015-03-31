function BreakScreen( exp_screen, window )
%BREAKSCREEN Summary of this function goes here
%   Detailed explanation goes here

Screen('TextFont', exp_screen, 'Monaco');
Screen('TextSize', exp_screen, 20);

white = WhiteIndex(exp_screen);
black = BlackIndex(exp_screen);
grey = white /2;

keysWanted = [KbName('space')];

text = ['It has been 10 minutes, feel free to take' ...
    'a break when you are ready to resume press the space bar'];

DrawFormattedText(exp_screen, text, 'center', ...
    'center', white, window.wrapAt,[],[], window.vSpacing);
Screen('Flip', exp_screen);

FlushEvents('keydown');
success = 0;
while success == 0
    pressed = 0;
    while pressed == 0
        [pressed, secs, kbData] = KbCheck;
    end
    for i = 1:length(keysWanted)
        if kbData(keysWanted(i)) == 1
            success = 1;
            keyPressed = keysWanted(i);
            FlushEvents('keydown');
            break;
        end;
    end;
    FlushEvents('keydown');
end

DrawISI( exp_screen, window.screenRect);
Screen('Flip', exp_screen);
WaitSecs(3);
end

