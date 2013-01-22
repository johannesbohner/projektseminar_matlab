function eigenwerte(latent, name, pfad)

figure('Name',['Eigenwerte ' name],'NumberTitle','off');

inProzent = 100/sum(latent).*latent;
integral = zeros(1,48);
for i=1:48
    integral(i) = sum(inProzent(1:i));
end
bar(integral(1:10),'y');
grid minor;
hold on;
title('Eigenwerte in Prozent');
bar(inProzent(1:10),'b');
hold off;
legend('Summe','Eigenwert');

print('-dpng',[pfad 'eigenwerte_' name]);

end

