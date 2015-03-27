function cvTask(subj)
% File directories
HELPER_DIR = fullfile(pwd, 'helpers');
IMG_DIR = fullfile(pwd, 'img');

addpath(HELPER_DIR, IMG_DIR);

% some config variables
CONDITIONS = {'free', 'forced', 'giving'};
EXCEL = {'charities.xlsx', 'Sheet1'};

if nargin<nargin('cvTask')
    Screen('CloseAll')
    clc
    fprintf('ERROR ***** call with missing subject parameter')
    return
end
data.subject = subj;
data.type = 'cvTask';
data.time = fix(clock);
data.filename = ['subj_' num2str(subj) '_cvTask.mat'];

%% Build trials structure
[~, ~, raw] = xlsread(EXCEL{1},EXCEL{2});

counter = 1;
for i=1:length(raw)
    for j = 1:5
        for k = 1:3
            data.trials(counter).name = raw{i};
            data.trials(counter).ammount = j*5;
            data.trials(counter).condition = CONDITIONS{k};
            data.trials(counter).random = rand;
            data.trials(counter).isi_time = round(random('unif',2,6));
            counter = counter + 1;
        end
    end 
end

% sort the trials to get a random order
[~, index] = sortrows([data.trials.random].');
data.trials = data.trials(index);
clear index;

%% Set up the screen/display
PsychDefaultSetup(2);
Screen('Preference', 'VisualDebugLevel', 1);
HideCursor;
screenNumber = max(Screen('Screens'));
window.black = BlackIndex(screenNumber);
[exp_screen, screenRect] = PsychImaging('OpenWindow', screenNumber, window.black);
[window.xPixels, window.yPixels] = Screen('WindowSize', exp_screen);
Screen('TextFont', exp_screen, 'Monaco');
Screen('TextSize', exp_screen, 20);
window.wrapAt = 75;
window.vSpacing = 1.3;

window.txt_color = [255 255 255];
window.white = WhiteIndex(exp_screen);
[window.xCenter, window.yCenter] = RectCenter(screenRect);

% Set up alpha blenidng for smooth (anti-aliased) lines
Screen('BlendFunction', exp_screen, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

%% response keys
KbName('UnifyKeyNames');
resp_keys = {'1!' '2@'};
data.keys.resp_key_codes = KbName(resp_keys);
data.keys.backCode = KbName('backspace');
data.keys.continueCode = KbName('space');

data.stimuliOnset = GetSecs;
response = RunTrials(exp_screen, screenRect, data, 3, 3, window)

save(data.filename);
Screen('CloseAll');
rmpath(HELPER_DIR);
rmpath(IMG_DIR);

