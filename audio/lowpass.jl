using AudioIO
using PyPlot

include("filters.jl")

if length(ARGS) < 3
    println("Usage: lowpass.jl input.flac critical-freq output.flac [filter-width]")
    exit()
end

freqCrit = float(ARGS[2])

if length(ARGS) == 4
    W = int(ARGS[4])
else
    W = 50
end

f = af_open(ARGS[1])

@assert f.sfinfo.channels == 1

samplerate = f.sfinfo.samplerate

h = lowpass(W)

x = float64(read(f))
close(f)

filtered_x = conv(x, h)

af_open(ARGS[3], "w") do f
    outsamps = int16(filtered_x)
    write(f, outsamps)
end
