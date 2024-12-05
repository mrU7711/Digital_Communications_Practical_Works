function symbols = mappingGray(bitsn, mComplex, mGray)

    N = length(bitsn);

    if mod(N, 4) ~= 0
        error('La longueur de la séquence binaire doit être un multiple de 4.');
    end

    numSymbols = N / 4;
    symbols = zeros(1, numSymbols);

    for k = 1:numSymbols
        bits = bitsn((k-1)*4+1:k*4);
        grayIndex = bi2de(bits, 'left-msb');
        [row, col] = find(mGray == grayIndex);
        symbols(k) = mComplex(row, col);
      end
    end

