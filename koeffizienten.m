function koeffizienten(s1,s2,name,pfad, numFreq)

figure('Name', ['Koeffizienten ' name],'NumberTitle','off','position',[150 0 1000 800]);


C = cell(size(s1,2),1);

subplot(2,1,1);
plot(s1(:,1));
grid on;
title('Koeffizienten der Eigenvektoren im zeitlichen Verlauf');
hold all;
C{1} = '1';
j = 1;
for i=s1(:,2:end) %2:size(s1,2)
    j = j + 1;
    plot(i);
    C{j} = int2str(j);
end
legend(C,'Location','NorthEastOutside');
hold off;

subplot(2,1,2);
plot(s2(:,1));
grid on;
title(['Annäherung durch cos (jeweils ' int2str(numFreq) ' Sinuswelle(n))']);
hold all;
for i=s2(:,2:end) 
    plot(i);
end
legend(C,'Location','NorthEastOutside');
hold off;

print('-dpng',[pfad 'koeffizienten_' name '_' int2str(size(s1,2)) '_eig_' int2str(numFreq) '_sin']);

end

