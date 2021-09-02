%% Set up
cd('~/src/speeded_target_identification/')
addpath('functions')
addpath('stim/test_words')

% Constants
Fs = 44100;
BLOCK = 0;
SUBJ_NUM = 0;
ptb = init_psychtoolbox(Fs);
[fullpath, word] = get_filepaths('stim/test_words');
training = true;

% s = 1;
for s = 1:length(fullpath)
    [stim_start, stim_end, pressed, rt, resp] = present_stimulus(fullpath{s}, BLOCK, ptb); % trigger sent here
    correct = check_answer(word{s}, resp);
    write_output(SUBJ_NUM, BLOCK, s, word{s}, stim_start, stim_end, pressed, rt, resp, correct);
    if training
        give_feedback(correct, ptb);
    end
end

% test check_answer and give_feedback with correct answer
% test with incorrect answer
% test with impossible answer
% test write_ouput

sca;