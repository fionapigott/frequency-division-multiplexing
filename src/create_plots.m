function create_plots
    [sample_1, fs, bits] = wavread("sample1.wav");
    [sample_2, fs2, bits2] = wavread("sample2.wav");

    if(fs != fs2)
        printf("Error: sample rates differ!\n");
        return
    elseif(bits != bits2)
        printf("Error: bitrates differ!\n");
        return
    end

    t1 = linspace(0, length(sample_1) / fs, length(sample_1))';
    t2 = linspace(0, length(sample_2) / fs, length(sample_2))';

    plot(t1, sample_1);
    xlabel("Time (seconds)", "fontsize", 18);
    ylabel("Relative displacement", "fontsize", 18);
    print -dpng sample1-orig.png

    plot(t2, sample_2);
    xlabel("Time (seconds)", "fontsize", 18);
    ylabel("Relative displacement", "fontsize", 18);
    print -dpng sample2-orig.png

    [freqs_1, power_1] = spectrum(sample_1, fs);
    [freqs_2, power_2] = spectrum(sample_2, fs);

    area(freqs_1, power_1);
    xlabel("Frequency (Hz)", "fontsize", 18);
    ylabel("Relative power", "fontsize", 18);
    print -dpng spectrum1-orig.png;

    area(freqs_2, power_2);
    xlabel("Frequency (Hz)", "fontsize", 18);
    ylabel("Relative power", "fontsize", 18);
    print -dpng spectrum2-orig.png;

    % Now pad one of the signals so they're the same length
    L1 = length(sample_1);
    L2 = length(sample_2);
    if(L1 > L2)
        sample_2 = [sample_2; zeros(L1 - L2, 1)];
        L2 = L1;
    else
        sample_1 = [sample_1; zeros(L2 - L1, 1)];
        L1 = L2;
    end

    combined = [sample_1 sample_2];
    stacked = stack(combined);

    [freqs_stacked, power_stacked] = spectrum(stacked, 2 * fs);
    area(freqs_stacked, power_stacked);
    xlabel("Frequency (Hz)", "fontsize", 18);
    ylabel("Relative power", "fontsize", 18);
    print -dpng spectrum-stacked.png;

    t = linspace(0, length(stacked) / (2 * fs), length(stacked));
    plot(t, stacked);
    xlabel("Time (seconds)", "fontsize", 18);
    ylabel("Relative displacement", "fontsize", 18);
    print -dpng stacked.png

    wavwrite(stacked, fs * 2, "stacked.wav");
    t_stacked = linspace(0, length(stacked) / (fs * 2), length(stacked));
    plot(t_stacked, stacked);
    xlabel("Time (seconds)", "fontsize", 18);
    ylabel("Relative displacement", "fontsize", 18);

    s = split(stacked, 2);
    sample_1 = s(:,1);
    sample_2 = s(:,2);

    t1 = linspace(0, length(sample_1) / fs, length(sample_1))';
    t2 = linspace(0, length(sample_2) / fs, length(sample_2))';

    plot(t1, sample_1);
    xlabel("Time (seconds)", "fontsize", 18);
    ylabel("Relative displacement", "fontsize", 18);
    print -dpng sample1-new.png;

    plot(t2, sample_2);
    xlabel("Time (seconds)", "fontsize", 18);
    ylabel("Relative displacement", "fontsize", 18);
    print -dpng sample2-new.png;

    wavwrite(sample_1, fs, "sample1-new.wav");
    wavwrite(sample_2, fs, "sample2-new.wav");
endfunction
