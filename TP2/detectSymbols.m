function detectedSymbols = detectSymbols(receivedSymbols, mComplex)
    N = length(receivedSymbols);
    detectedSymbols = zeros(1, N);

    % Parcourir chaque symbole reçu
    for i = 1:N
        % Calculer la distance entre le symbole reçu et chaque symbole de la constellation
        [~, index] = min(abs(mComplex(:) - receivedSymbols(i)));
        % Trouver le symbole de la constellation le plus proche
        detectedSymbols(i) = mComplex(index);
      end
    end

