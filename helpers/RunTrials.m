function [response, stimuliOnset] = RunTrials( exp_screen, data, trial, presTime, isiTime, window)

%TIMER Summary of this function goes here
%   Detailed explanation goes here

%DrawFormattedText(exp_screen, 'Press 1 or 2',...
%                'center', 'center', screenSettings.white, screenSettings.wrapAt, [], [], screenSettings.vSpacing);

stimuliOnset = GetSecs;

if strcmp(data.trials(trial).condition, 'forced')
    
    if round(rand) == 1
        response = KbName(data.keys.yesKey);
    else
        response = KbName(data.keys.noKey);
    end
    while GetSecs-stimuliOnset < presTime + isiTime
        while GetSecs-stimuliOnset < presTime
            DrawTrialScreen(data, trial, exp_screen, window, response);
            Screen(exp_screen, 'Flip');
        end
        DrawISI(exp_screen, window.screenRect);
        Screen('Flip', exp_screen);
    end
else
    
   DrawTrialScreen(data, trial, exp_screen, window);
   while GetSecs-stimuliOnset < presTime + isiTime
        if exist('keyIsDown', 'var') == 0
            Screen(exp_screen, 'Flip');
            while GetSecs-stimuliOnset < presTime
                [keyIsDown, secs, keyCode] = KbCheck;
                if keyIsDown == 1 && any(keyCode(data.keys.resp_key_codes))
                    response = KbName(keyCode);
                    DrawTrialScreen(data, trial, exp_screen, window, response)
                    Screen(exp_screen, 'Flip');
                    WaitSecs(.7);
                    break;
                end
            end
        end
        if exist('response', 'var') == 0
            response = false;
        end
        DrawISI(exp_screen, window.screenRect);
        Screen('Flip', exp_screen);
   end

   
end

