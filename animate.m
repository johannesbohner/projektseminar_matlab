function animate(name,pfad,m1,m2,m3,fps,numEig,numFreq)

figure('position',[50 0 800 800],'Name',[name ' ' int2str(numEig) ' Eigenvektoren ' int2str(numFreq) ' Sinuswellen(en)'],'NumberTitle','off');

F = getframe;

[numFrames, numComp]= size(m1);

for j=1:numFrames
    row1 = m1(j,1:end);
    row2 = m2(j,1:end);
    row3 = m3(j,1:end);
    length = numComp/3;
    X1 = zeros(length,1);
    Y1 = zeros(length,1);
    Z1 = zeros(length,1);
    X2 = zeros(length,1);
    Y2 = zeros(length,1);
    Z2 = zeros(length,1);
    X3 = zeros(length,1);
    Y3 = zeros(length,1);
    Z3 = zeros(length,1);
    for i=1:length
        X1(i) = row1(((i-1)*3)+1);
        Y1(i) = row1(((i-1)*3)+2);
        Z1(i) = row1(((i-1)*3)+3);
        X2(i) = row2(((i-1)*3)+1);
        Y2(i) = row2(((i-1)*3)+2);
        Z2(i) = row2(((i-1)*3)+3);
        X3(i) = row3(((i-1)*3)+1);
        Y3(i) = row3(((i-1)*3)+2);
        Z3(i) = row3(((i-1)*3)+3);
    end
    % Original
    plot(X1,Y1,'bo');
    hold on;
    axis equal;
    axis([-1 4 -4.2 1.5]);
    p1 = plot(X1,Y1,'b.');
    % Original und PCA
    plot(X1+3,Y1,'bo');
    p2 = plot(X2+3,Y2,'r.');
    % PCA und Fit
    plot(X2+3,Y2-3,'ro');
    p3 = plot(X3+3,Y3-3,'k.');
    % Fit
    plot(X3,Y3-3,'ko');
    plot(X3,Y3-3,'k.');
    % Original und Fit
    plot(X1+1.5,Y1-1.5,'bo');
    plot(X3+1.5,Y3-1.5,'k.');
    legend([p1 p2 p3],'Originaldaten','PCA','PCA und Fit','Location','South');
    hold off;
    F(j)=getframe;
end

% Film als .avi abspeichern
writerObj = VideoWriter([pfad 'animation_' name '_' int2str(numEig) '_eig_' num2str(numFreq) '_sin.avi']);
writerObj.FrameRate = 30;
writerObj.Quality = 100;
open(writerObj);

for k = 1:numFrames
   writeVideo(writerObj,F(k));
end

close(writerObj);

movie(F,20,fps);

end

