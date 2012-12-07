% A demonstration of using the FFT to compute a representation of the
% spectrum which is suitable for plotting.
% Arguments:
%   signal: Some time-varying signal
%   fs:     The sampling frequency of that signal, in Hz
% Return values:
%   freqs: An array of frequencies in the signal
%   y:     The relative power of each frequency in freqs
function [freqs, power] = spectrum(signal, fs)
    % The FFT is usually done with a divide-and-conquer algorithm that will
    % run faster for a very composite number of samples, so we get a power of
    % two.
    L = length(signal);
    NFFT = 2^(nextpow2(L));

    % Compute the FFT and find the relative power of the lower sideband
    % (positive frequencies)
    hatted = fft(signal, NFFT)/L;
    lower = hatted(1:NFFT/2);
    power = 2*abs(lower);

    % The sampling theorem tells us that these frequencies will range from
    % 0 to half of the sampling frequency, so we compute those.
    freqs = linspace(0, fs/2, NFFT/2);
endfunction
