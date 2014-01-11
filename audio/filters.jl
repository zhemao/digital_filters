function lowpass(W)
    M = 2 * W

    t = [-W:W] / samplerate
    i = [0:M]

    h = sin(2 * pi * freqCrit * t) ./ (2 * pi * freqCrit * t)
    h[W + 1] = 1
    h .*= (0.54 - 0.46 * cos(2 * pi * i / M))
    h ./= sum(h)

    return h
end

function highpass(W)
    h = -lowpass(W)
    h[W + 1] += 1.0
    return h
end
