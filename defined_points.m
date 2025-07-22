%% DEFINED POINTS

% Simulo che il centro di massa, e di conseguenza il piano contenente i
% propellers , è a 2 dm da terra. Infatti Se implemento il ground effect,
% il controllo dà problemi se parto da altezza z = 0, perché essendo la
% distanza dal ground nulla, il coefficiente k_GE sarà assurdamente alto.
% Da altezza 0.2 a salire è tutto a posto
points = [0 0 0.2; 
          0 0 1.2
          0 1 1.2;  
          1 1 1.2;
          2 1 1.2;
          2 1 2.2
          3 1 2.2;
          3 1 3.2;
          4 1 3.2;
          4 1 2.2;  % hovering da qua ...
          4 1 2.2]; % ...a qua

n = size(points,1);