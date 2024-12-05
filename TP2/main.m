clear all;
close all;
clc;


% Visualiser la constellation M-QAM et le codage de Gray
% Paramètres d'entrée :
% M : taille de la constellation (exemple : M = 16 pour la 16-QAM)
% mComplex : matrice contenant les symboles complexes de taille (sqrt(M), sqrt(M))
% mGray : matrice contenant les codes de Gray (en décimal) de taille (sqrt(M), sqrt(M))

M = 16;  % Taille de la constellation

N = 512;
sigma2=0.5;

mComplex = const16QAM();
mGray = Gray16QAM();
% Émetteur
% Extraire les parties réelle et imaginaire des symboles
%% Constellation 16-QAM
g0=1;
bits = genBin(N);
an = mappingGray(bits, mComplex, mGray);
rn = canalAWGN(an, sigma2);
an_estimated = detectSymbols(rn, mComplex);
bitsn_estimated = demapGray(an_estimated, mComplex, mGray);


symbols = mappingGray(bits, mComplex, mGray);
receivedSymbols = canalAWGN(symbols, sigma2);
DS = detectSymbols(receivedSymbols, mComplex);
RDG=demapGray(DS, mComplex, mGray);


A=[bits, bitsn_estimated, an, an_estimated];
x = real(receivedSymbols(:));
y = imag(receivedSymbols(:));
z = mGray(:);

x1= real(symbols(:));
y1= imag(symbols(:));

x2= real(DS(:));
y2= imag(DS(:));

num_errors_bits = sum(bits ~= bitsn_estimated) % Nombre d'erreurs binaires
BER = num_errors_bits / N % Taux d'erreur binaire

num_errors_symbols = sum(an ~= an_estimated) % Nombre d'erreurs de symboles
SER = num_errors_symbols / (N / 4) % Taux d'erreur symbole

% Créer une nouvelle figure
figure;

% Dessiner les points de la constellation
scatter(x, y, 5, 'r', 'filled');
hold on;
#scatter(x1, y1, 10, 'r', 'filled');
scatter(x2, y2, 5, 'b', 'filled');
% Définir les limites des axes
axis([-sqrt(M) sqrt(M) -sqrt(M) sqrt(M)]);
xlabel('I (Partie Réelle)', 'FontWeight', 'bold', 'FontSize', 12);
ylabel('Q (Partie Imaginaire)', 'FontWeight', 'bold', 'FontSize', 12);
legend('Symboles reçues','les symboles de la 16-QAM');
grid on;


for k = 1:M
    % Afficher le code de Gray en binaire
    text(x(k) - 0.6, y(k) + 0.3, dec2base(z(k), 2, log2(M)), ...
        'Color', [1 0 0], 'FontSize', 12);
end

% Ajouter un titre
title('Symboles reçues avec les symboles de la 16-QAM')
figure(2)

stem(RDG,'filled')
title('signal décodé')
xlabel('index')
ylabel('valeurs')

figure(3)
subplot(3,1,1);
stem(bits,'filled');
title('signal envoyé')
xlabel('index')
ylabel('valeurs')

subplot(3,1,2);
stem(RDG,'filled');
title('signal décodé')
xlabel('index')
ylabel('valeurs')
% Calcul de l'erreur (différence entre les bits originaux et décodés)
erreur = bits ~= RDG;

subplot(3,1,3);
stem(erreur,'filled');
title('erreur bits')
xlabel('index')
ylabel('valeurs')








##% Paramètres de simulation
% Simulation de la chaîne 16-QAM

##[bitsn, bits_dn, an, ban] = chaine16QAM(N, sigma2_b, g0);
##N = 10000; % nombre de bits

##g0 = 1; % gain de transmission

##EbN0_dB = 0:12; % valeurs de Eb/N0 en dB

##

##% Initialisation des vecteurs de taux d'erreur

##ber_sim = zéros(size(EbN0_dB));

##ser_sim = zéros(size(EbN0_dB));

##ser_sim(i) = sum(an ~= ban) / (N / 4);

##

##% Paramètres de simulation

##N = 10000; % nombre de bits

##g0 = 1; % gain de transmission

##EbN0_dB = 0:12; % valeurs de Eb/N0 en dB

##

##% Initialisation des vecteurs de taux d'erreur

##ber_sim = zéros(size(EbN0_dB));

##ser_sim = zéros(size(EbN0_dB));

##

##for i = 1:length(EbN0_dB)

##    % Calcul de sigma2_b pour chaque Eb/N0

##    EbN0 = 10^(EbN0_dB(i)/10);

##    sigma2_b = g0 / (2 * EbN0 * log2(16)); % variance du bruit pour 16-QAM


##    % Calcul du taux d'erreur symbole (SER) et binaire (BER)

##    ser_sim(i) = sum(an ~= ban) / (N / 4); % N/4 pour 16-QAM

##    ber_sim(i) = sum(bitsn ~= bits_dn) / N;

##end

##

##% Calcul de la probabilité d'erreur théorique pour 16-QAM

##Pb_theoretical = (3/2) * qfunc(sqrt(0.1 * 10.^(EbN0_dB/10)));

##Pe_symbol_theoretical = 1 - (1 - Pb_theoretical).^2;

##

##% Tracé des courbes d'erreur

##figure;

##semilogy(EbN0_dB, ber_sim, 'o-', 'LineWidth', 2); hold on;

##semilogy(EbN0_dB, ser_sim, 's-', 'LineWidth', 2);

##semilogy(EbN0_dB, Pb_theoretical, 'r--', 'LineWidth', 2);

##semilogy(EbN0_dB, Pe_symbol_theoretical, 'b--', 'LineWidth', 2);

##xlabel('E_b/N_0 (dB)');

##ylabel('Taux d''erreur');

##legend('BER simulé', 'SER simulé', 'BER théorique', 'SER théorique');

##grid on;

##title('Courbes d''erreur pour la modulation 16-QAM');

##





