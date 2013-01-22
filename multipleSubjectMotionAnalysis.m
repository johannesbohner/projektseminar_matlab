clear;
clc;

% names = {'taminoHampelmann0'; 'burkhardHampelmann0'; 'andreasHampelmann0'; 'johannesHampelmann0'
%          'davidHampelmann0'; 'oemerHampelmann0'; 'olafHampelmann0'; 'thomasHampelmann0'; 'christianHampelmann0';
%          'taminoHampelmann5'; 'burkhardHampelmann5'; 'andreasHampelmann5'; 'johannesHampelmann5'
%          'davidHampelmann5'; 'oemerHampelmann5'; 'olafHampelmann5'; 'thomasHampelmann5'; 'christianHampelmann5'};
     
names = {'taminoSeilhüpfen0'; 'burkhardSeilhüpfen0'; 'andreasSeilhüpfen0'; 'johannesSeilhüpfen0'
         'davidSeilhüpfen0'; 'sabrinaSeilhüpfen0'; 'olafSeilhüpfen0'; 'thomasSeilhüpfen0'; 'christianSeilhüpfen0'};
         %'taminoSeilhüpfen5'; 'burkhardSeilhüpfen5'; 'andreasSeilhüpfen5'; 'johannesSeilhüpfen5';
         %'davidSeilhüpfen5'; 'sabrinaSeilhüpfen5'; 'olafSeilhüpfen5'; 'thomasSeilhüpfen5'; 'christianSeilhüpfen5'};

numNames = size(names,1);

motionVectors = zeros(numNames,150);

for i=1:numNames
     motionVectors(i,:) = motionAnalysis(char(names(i)));
end

%[V,K,LATENT] = princomp(motionVectors); % Hauptkomponentenanlyse

numFrames = 300; %10s

motionVectors(numNames+1,:) = mean(motionVectors);

subject = numNames+1;

val = zeros(2,3);
val(1,:) = motionVectors(subject,145:147);
val(2,:) = motionVectors(subject,148:150);

score = zeros(numFrames,2);
for i=1:2
    reconst = zeros(1,numFrames);
    for j=1:1
        reconst = reconst + val(i,3*j-2)*sin((1:numFrames)*val(i,3*j-1)+val(i,3*j));
    end
    score(:,i) = reconst';
end

coeff = zeros(48,2);
coeff(:,1) = motionVectors(subject,49:96);
coeff(:,2) = motionVectors(subject,97:144);

p0 = motionVectors(subject,1:48);
P0 = ones(numFrames,1)*p0; % Matrix mit der Durchschnittspose in jeder Spalte

M = P0 + score*coeff';

for i=1:numFrames
    row = M(i,:);
    X = zeros(16,1);
    Y = zeros(16,1);
    Z = zeros(16,1);
    for j=1:16
        X(j) = row(((j-1)*3)+1);
        Y(j) = row(((j-1)*3)+2);
        Z(j) = row(((j-1)*3)+3);
    end
    plot(X,Y,'bo');
    axis equal;
    axis([-1.5 1.5 -1.5 1.5]);
    
    F(i) = getframe;
end

% Film als .avi abspeichern
writerObj = VideoWriter('motionVectorSeilhuepfen0.avi');
writerObj.FrameRate = 30;
writerObj.Quality = 100;
open(writerObj);

for k = 1:numFrames
   writeVideo(writerObj,F(k));
end

close(writerObj);

plot(0);