function bpskSignal = genBPSK(N)
    randomValues = rand(1,N);
    bpskSignal = sign(randomValues-0.5);
end