function demo(file1, file2)
    [sample_1, fs, bits] = wavread(strcat(file1, ".wav"));
    sample_1 = sample_1(:,1);
    sample_2 = wavread(strcat(file2, ".wav"))(:,1);
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
    wavwrite(stacked, 2*fs, strcat(file1, "-combined.wav"));
    out = split(stacked, 2);
    wavwrite([out(:,1) out(:,1)], fs, strcat(file1, "-new.wav"));
    wavwrite([out(:,2) out(:,2)], fs, strcat(file2, "-new.wav"));
endfunction
