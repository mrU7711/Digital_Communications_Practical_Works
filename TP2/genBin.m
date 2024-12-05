%% Fonction genBin
% Génère des bits uniformément distribués entre 0 et 1

function [bits] = genBin(N)
  bits = randi([0,1],1,N);
end

