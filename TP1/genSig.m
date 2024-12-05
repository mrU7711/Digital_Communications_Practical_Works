function xn=genSig(N)
    an2=genBPSK(N);
    h=[0.5, 0.2];
    xn=filter(h, 1, an2);
end