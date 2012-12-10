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
    title("Sample 1 in time domain");
    xlabel("Time (seconds)");
    ylabel("Relative displacement");
    print -dpng sample1-orig.png

    plot(t2, sample_2);
    title("Sample 2 in time domain");
    xlabel("Time (seconds)");
    ylabel("Relative displacement");
    print -dpng sample2-orig.png

    [freqs_1, power_1] = spectrum(sample_1, fs);
    [freqs_2, power_2] = spectrum(sample_2, fs);

    area(freqs_1, power_1);
    title("Sample 1 in frequency domain");
    xlabel("Frequency (Hz)");
    ylabel("Relative power");
    print -dpng spectrum1-orig.png;

    area(freqs_2, power_2);
    title("Sample 2 in frequency domain");
    xlabel("Frequency (Hz)");
    ylabel("Relative power");
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
    title("Modulated output in frequency domain");
    xlabel("Frequency (Hz)");
    ylabel("Relative power");
    print -dpng spectrum-stacked.png;

    t = linspace(0, length(stacked) / (2 * fs), length(stacked));
    plot(t, stacked);
    title("Modulated output in time domain");
    xlabel("Time (seconds)");
    ylabel("Relative displacement");
    print -dpng stacked.png

    wavwrite(stacked, fs * 2, "stacked.wav");
    t_stacked = linspace(0, length(stacked) / (fs * 2), length(stacked));
    plot(t_stacked, stacked);
    title("Modulated output in time domain");
    xlabel("Time (seconds)");
    ylabel("Relative displacement");

    s = split(stacked, 2);
    sample_1 = s(:,1);
    sample_2 = s(:,2);

    t1 = linspace(0, length(sample_1) / fs, length(sample_1))';
    t2 = linspace(0, length(sample_2) / fs, length(sample_2))';

    plot(t1, sample_1);
    title("Recovered sample 1 in time domain");
    xlabel("Time (seconds)");
    ylabel("Relative displacement");
    print -dpng sample1-new.png;

    plot(t2, sample_2);
    title("Recovered sample 2 in time domain");
    xlabel("Time (seconds)");
    ylabel("Relative displacement");
    print -dpng sample2-new.png;

    wavwrite(sample_1, fs, "sample1-new.wav");
    wavwrite(sample_2, fs, "sample2-new.wav");
endfunction
