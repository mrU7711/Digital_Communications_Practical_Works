function mComplex = const16QAM()
    % Définir les valeurs possibles de a_I et a_Q
    aI = [-3, -1, 1, 3];
    aQ = [-3, -1, 1, 3];

    % Initialiser la matrice complexe
    mComplex = zeros(4, 4);

    % Générer la constellation complexe
    for i = 1:4
        for j = 1:4
            mComplex(i, j) = aI(i) + 1j * aQ(j);
          end
        end
      end

