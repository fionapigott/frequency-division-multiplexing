% Function to split a signal previously created by stack into its constituent
% signals.
% Arguments:
%     signal: The composite signal created by stack
%     n:      The number of output signals we expect to get back
% Returns: An m by n array of signals, where m is the number of samples in each
function retval = split(signal, n)
    transformed = fft(signal);
    L = length(transformed);

    % Take out the redundant information from the signal
    reduced = transformed(1:L/2+1);

    % Split the remaining information into n different signals
    split = reshape(reduced, length(reduced) / n, n);

    % Reconstruct the previously discarded information to make the ifft real
    mirrored = flipud(conj(split(2:length(split)-1,:)));
    retval = real(ifft([split; mirrored]));
end
