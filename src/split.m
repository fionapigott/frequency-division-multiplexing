function retval = split(signal, n)
    transformed = fft(signal);
    L = length(transformed);

    reduced = transformed(1:L/2+1);

    split = reshape(reduced, length(reduced) / n, n);
    mirrored = flipud(conj(split(2:length(split)-1,:)));
    retval = real(ifft([split; mirrored]));
endfunction
