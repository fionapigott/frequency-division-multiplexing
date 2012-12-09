% A function to concatenate two REAL signals in frequency and return a new
% signal containing all those frequencies. This is done by taking the DFT of
% each input signal, stripping away the redundant frequencies, concatenating
% the remaining frequencies, and then adding redundant frequencies back in to
% satisfy the reality condition. Finally, the ifft is taken to get a real
% signal back.
% Arguments:
%     signals: An m by n array containing n different signals with m samples
% Returns: A new signal with all frequency information from the input signals.
function retval = stack(signals)
    % The FFT is usually done with a divide-and-conquer algorithm that will
    % run faster for a very composite number of samples, so we get a power of
    % two.
    [L count] = size(signals);
    NFFT = 2^(nextpow2(L));

    transformed = fft(signals, NFFT);

    % For a real signal, we know that the top half of the fft array (the
    % negative frequencies) is simply the complex conjugates of the bottom half
    % (the positive frequencies). We remove the redundant frequency
    % information.
    concatenated = transformed(1:NFFT/2+1,:)(:);

    % plot(abs(concatenated));
    % Finally, we concatenate our signal with a mirror of its complex
    % conjugates so that the ifft will be real.
    mirrored = flipud(conj(concatenated(2:rows(concatenated) - 1)));

    retval = real(ifft([concatenated; mirrored]));
endfunction
