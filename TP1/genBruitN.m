function bruitSignal= genBruitN(N,sigma)
    randomValues= randn(1,N);
    bruitSignal= sigma*randomValues;
end