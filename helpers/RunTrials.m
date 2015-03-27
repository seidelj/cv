function response = RunTrials( exp_screen, screenRect, data, presTime, isiTime, window)

%TIMER Summary of this function goes here
%   Detailed explanation goes here

%DrawFormattedText(exp_screen, 'Press 1 or 2',...
%                'center', 'center', screenSettings.white, screenSettings.wrapAt, [], [], screenSettings.vSpacing);
DrawTrialScreen(data, exp_screen, screenRect, window);

while GetSecs-data.stimuliOnset < presTime + isiTime
    if exist('keyIsDown', 'var') == 0
        Screen(exp_screen, 'Flip');
        while GetSecs-data.stimuliOnset < presTime
            [keyIsDown, secs, keyCode] = KbCheck;
            if keyIsDown == 1 && any(keyCode(data.keys.resp_key_codes))
                response = KbName(keyCode);
                DrawTrialScreen(data, exp_screen, screenRect, window)
                WaitSecs(.5);
                break;
            end
        end
    end
    if exist('response', 'var') == 0
        response = false;
    end
    DrawISI(exp_screen, screenRect);
    Screen('Flip', exp_screen);
end


