% function motionVector = motionAnalysis(name)

clear;
clc;

name = 'burkhard';
gewicht = '5';
bewegung = 'Hampelmann';
normalize = '';
% Seilh�pfen normalize Hampelmann

fps = 30;
% Framerate, wird nur f�r die Darstellung im Matlabplot ben�tigt

pfad = [name bewegung '/'];

name = [name bewegung gewicht normalize];

M = dlmread([pfad name '.txt']);
% Matrix der erhobenen Daten. Zeilen: zeitlich aufeinanderfolgende Posen

startFactor = 0;
endFactor = 1;
% name = [name '_10_zyk'];

M = M(end*startFactor+1:(end-1)*endFactor,:); % Weglassen der letzten Zeile, da nicht intakt

% handr = M(:,23);
% handl = M(:,20);
% plot(handr);
% hold all;
% plot(handl);
% hold off;

[numFrames, numComp]= size(M);
%numComp ist die Anzahl der Dimensionen der Vektoren, die eine einzelne Pose beschreiben
%numFrames ist die Anzahl der Posen/Frames aus den Testdaten

numEigenvectors = 2;
% Anzahl der Eigenvektoren, die verwendet werden sollen
% Definitionsbereich = {1,...,numComp}

numWav = 2;
% Anzahl der Sinuswellen, die in der angen�herten Koeffizientenfunktion enthalten sein sollen
% Definitionsbereich = {1,...,numFrames/2} (Fouriertransformation) oder {1,...,8} (fit)
 
[COEFF,SCORE,LATENT] = princomp(M); % Hauptkomponentenanlyse

eigenwerte(LATENT,name,pfad);

p0 = mean(M(:,1:numComp)); % Durchschnittspose bestimmen

P0 = ones(numFrames,1)*p0; % Matrix mit der Durchschnittspose in jeder Spalte

x = 1:numFrames;

% SCORE = SCORE(:,1:5); % Weglassen der nicht ben�tigten Koeffizienten
% COEFF = COEFF(:,1:5); % Weglassen der nicht ben�tigten Eigenvektoren
% 
% val = zeros(numEigenvectors, numWav*3);
% for i=1:numEigenvectors
%    val(i,:) = coeffvalues(fit(x',SCORE(:,i),['sin' int2str(numWav)]));
% end
% 
% resultScore = zeros(size(SCORE));
% for i=1:numEigenvectors
%     %[a,f,p] = calcParameters(SCORE(:,i)); %(alte L�sung)
%     reconst = zeros(1,numFrames);
%     for j=1:numWav
%         reconst = reconst + val(i,3*j-2)*sin((1:numFrames)*val(i,3*j-1)+val(i,3*j));
%     end
%     resultScore(:,i) = reconst';
% end

SCORE = SCORE(:,1:numEigenvectors); % Weglassen der nicht ben�tigten Koeffizienten
COEFF = COEFF(:,1:numEigenvectors); % Weglassen der nicht ben�tigten Eigenvektoren

% grundsin = coeffvalues(fit(x',SCORE(:,1),'sin1'));

%x = (0:4*pi/numFrames:4*pi*(1-1/numFrames)); %(alte L�sung)
% val = fitHampelmann(SCORE,numEigenvectors, numFrames);
val = zeros(numEigenvectors, numWav*3);
for i=1:numEigenvectors
   val(i,:) = coeffvalues(fit(x',SCORE(:,i),['sin' int2str(numWav)]));
end


resultScore = zeros(size(SCORE));
for i=1:numEigenvectors
    %[a,f,p] = calcParameters(SCORE(:,i)); %(alte L�sung)
    reconst = zeros(1,numFrames);
    for j=1:numWav
        reconst = reconst + val(i,3*j-2)*sin((1:numFrames)*val(i,3*j-1)+val(i,3*j));
    end
    resultScore(:,i) = reconst';
end

koeffizienten(SCORE,resultScore,name,pfad,numWav);

Zwischenergebnis = P0 + SCORE*COEFF';
 
Ergebnis = P0 + resultScore*COEFF';

val = val';
motionVector = [p0 COEFF(1:end) val(1:end)];
% 
dlmwrite([pfad name 'MotionVectorCalc.txt'],motionVector);

animate(name,pfad,M,Zwischenergebnis,Ergebnis,fps,numEigenvectors,numWav);

% end