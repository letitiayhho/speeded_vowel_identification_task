function [stim_start, stim_end, pressed, rt, resp] = present_stimulus(stim, ptb)

    [aud, ~] = audioread(stim);
    PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);

    % show response accepting
    DrawFormattedText(ptb.window, 'x', 'center', 'center', 1);
    Screen('Flip', ptb.window);
    
    % start collecting response
    KbQueueCreate(ptb.keyboard);
    ListenChar(2);
    KbQueueStart;

    % play audio
    t0 = GetSecs + .001;
    PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);

    % stop audio
    [stim_start, ~, ~, stim_end] = PsychPortAudio('Stop', ptb.pahandle, 1, 1);

    % Collect response
    [pressed, rt] = KbQueueCheck;
    resp = KbName(rt);
    [rt, I] = min(rt(rt > 0)); % keep only first response
    resp = char(resp(I));

    % Wait
    WaitSecs(.2 + rand()*.2);
    KbQueueStop;
    KbQueueRelease;
    ListenChar(0); % renables matlab command window

    % end of accepting response
    Screen('Flip', ptb.window);

end