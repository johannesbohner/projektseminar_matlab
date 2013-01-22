clc;
score = SCORE(:,1);

numFrames = size(score,1);

x=1:numFrames;

f = fittype('a*sin(x*b+c)');
% f =
%      General model:
%        f(a,b,n,x) = a*x^2+b*exp(n*x)
c = fit(x',score,f);
% c =
%      General model:
%        c(x) = a*x^2+b*exp(n*x)
%      Coefficients:
%        a =           1
%        b =        10.3
%        n =        -100

plot(score);
hold all;
plot(c);
hold off;