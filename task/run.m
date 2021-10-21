%%%%%%%%%%%%%%%%%%%%%%%%% UPDATE THIS SECTION BEFORE EACH SUBJECT/TEST

SUBJ_NUM = 0; % numeric
BLOCK = 1; % numeric
RTBOX = false; % logical

%%%%%%%%%%%%%%%%%%%%%%%
      
PsychDebugWindowConfiguration

%% Set up
cd('~/src/speeded_target_recognition_task')
addpath('generate_stim_order')
addpath('task/functions')
addpath('task/USTCRTBox_003')      
PsychJavaTrouble(1);

% set up psychtoolbox and RTBox
init_RTBox(RTBOX);
FS = 44100;
PTB = init_psychtoolbox(FS);

% Load stim order
[STIM, N_TRIALS] = generate_stim_order(SUBJ_NUM, BLOCK);

%% Display instructions
update_instructions(BLOCK)
instructions(PTB, BLOCK);

%% Task
for trial = 1:N_TRIALS
    [vowel, path, istarget, target, trial_type] = get_trial_stim(STIM, trial);

    % loop through all stim in trial
    WaitSecs(2)
    fixation(PTB); % show fixation cross to start trial
    present_target(PTB, target) % show target

    for v = 1:length(path)
        [rt, resp] = present_stimulus(path(v), PTB); % trigger sent here
        [correct] = check_answer(istarget(v), resp);
        write_output(SUBJ_NUM, BLOCK, BLOCK_TYPE, trial, trial_type, v,...
            vowel(v, :), target, istarget(v), rt, resp, correct);
        if BLOCK == 1
            give_feedback(correct, PTB);
        end
    end
end

%% end block
instructions(PTB, 0) 

sca; % screen clear all
close all;
clearvars;
PsychPortAudio('Close'); % clear audio handles
