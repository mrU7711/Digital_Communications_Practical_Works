function receivedSymbols = canalAWGN(symbols, sigma2)
    % Ajoute du bruit AWGN aux symboles
    N = length(symbols);
    noise = sqrt(sigma2/2) * (randn(1, N) + 1j * randn(1, N));
    receivedSymbols = symbols+noise;
end
