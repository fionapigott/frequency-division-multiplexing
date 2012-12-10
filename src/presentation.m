function demo
    fs = 1000; % Hz
    T  = 5;    % Seconds
    t  = linspace(0, T, T * fs); % Our time vector
    x  = sin(2*pi*5*t); % 5 Hz sine wave
    plot(t,x);
    pause

    L = length(x);
    NFFT = 2^nextpow2(L);
    X = fft(x, NFFT);
    replicated = [X X X];
    f = linspace(-3*fs/2, 3*fs/2, 3*NFFT);
    plot(f, abs(replicated));
endfunction
