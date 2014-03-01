function demo
    fs = 100; % Hz
    T  = 1;    % Seconds
    t  = linspace(0, T, T * fs); % Our time vector
    x  = sin(2*pi*5*t); % samples of a 5 Hz sine wave
    figure(1)
    plot(t,x,'k*');
    hold on 
    twave = linspace(0, T, T * 1000); % use this to plot the actual wave
    xwave  = sin(2*pi*5*twave); % 5 Hz sine wave
    plot(twave,xwave);
    
    figure(2)
    grid on
    L = length(x);
    NFFT = 2^nextpow2(L);
    X = fft(x, NFFT);
    replicated = [X X X];
    f = linspace(-3*fs/2, 3*fs/2, 3*NFFT);
    plot(f, abs(replicated));
end
