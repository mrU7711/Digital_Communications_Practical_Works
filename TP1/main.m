clc
close all
clear all

% paramètres d'entrées
N=512; %nombre d'échantillons
sigma=sqrt(0.5);
nbr_iterations=100;
g0=1;

%génération des signaux
bpkSignal = genBPSK(N);
bruitSignal = genBruitN(N, sigma);

%erreurs
total_erreurs=0;
for i = 1:nbr_iterations
    an=genBPSK(N);
    bruitSignal=genBruitN(N,sigma);
    rn=an+bruitSignal;
    an_estime=decodeBPSK(rn);
    erreur=sum(an_estime ~= an);
    total_erreurs = (total_erreurs + erreur);
end

%taux erreur binaire
total_erreurs = (total_erreurs + erreur)/(N*nbr_iterations)


%calcul de de taux d'erreur pour differentes valeurs de Eb/N0
Dbmax=12;
hnEb0_idb = 0:Dbmax;
BER = zeros(1,length(hnEb0_idb));
for i = 1:length(hnEb0_idb)
    total_erreurs1=0;
    sigma_b=sqrt(1 / (2*10^(hnEb0_idb(i) /10 )));
    an1=genBPSK(N);
    bruitSignal1=genBruitN(N,sigma_b);
    rn1=an1+bruitSignal1;
    an1_estime=decodeBPSK(rn1);
    erreur1=sum(an1_estime ~= an1);
    total_erreurs1 = (total_erreurs1 + erreur1);
    BER(i)= total_erreurs1/N;
end
%calcul de probabilité d'erreur binaire theorique Pb
vect = 0:Dbmax;
Pb_theorique= 0.5*erfc(sqrt(10.^(vect /10)));

%simulation
figure(1);
subplot(2,1,1)
stem(bpkSignal,'filled')
title('Diagramme du signal BPSK')
xlabel('index')
ylabel('valeurs')
grid on

subplot(2,1,2)
hist(bpkSignal, 30)
title('Histogramme du signal BPSK')
xlabel('valeurs')
ylabel('fréquence')
grid on

figure(2);
subplot(3,1,1)
hist(bruitSignal, 30)
title('Histogramme du signal bruité')
xlabel('valeurs')
ylabel('fréquence')
grid on

subplot(3,1,2)
hist(bpkSignal, 30)
title('Histogramme du signal BPSK')
xlabel('valeurs')
ylabel('fréquence')
grid on

subplot(3,1,3)
stem(bruitSignal,'filled')
title('Diagramme du signal bruité')
xlabel('index')
ylabel('valeurs')
grid on

figure(3);

subplot(3,1,1)
stem(bpkSignal,'filled')
title('Signal BPSK transmis (an)')
xlabel('Index')
ylabel('Valeurs de BPSK')
grid on

subplot(3,1,2)
stem(rn,'filled')
title('Signal reçu rn (BPSK et bruit)')
xlabel('Index')
ylabel('Amplitude du Signal')
grid on

subplot(3,1,3)
stem(an_estime,'filled')
title('Signal BPSK décodé')
xlabel('Index')
ylabel('Valeurs de BPSK')
grid on


figure(4);
plot(rn);
title('Signal reçu rn (BPSK et bruit)')
xlabel('Index')
ylabel('Amplitude du Signal')
grid on

figure(5);
semilogy(hnEb0_idb, BER, '-*', 'DisplayName','BER simulé');
title('Probabilité d erreur binaire de la BPSK');
xlabel('Eb/N0(dB)')
ylabel('Pb_theorique')
hold on;
grid on;
semilogy(vect, Pb_theorique,'LineWidth',2,'DisplayName','Pb_theorique');


%recherche de SNR pour un BER de 10e-3
BER_voulu = 10.^-3;
[~, idx]=min(abs(BER-BER_voulu));
SNR_dB=hnEb0_idb(idx);
SNR=10.^(SNR_dB*2/10);


figure(6)
subplot(2,1,1)
xn=genSig(N);
hist(xn);
xlabel('échantillons');
title('HISTOGRAME');
subplot(2,1,2)
stem(xn);
xlabel('échantillons');
ylabel('amplitude');
title('signal utile xn');
grid on;
