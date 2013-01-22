function [amplitude,frequency,phase] = calcParameters(score)
d = fft(score);

len = size(score,1);
ampFac = len/2;

amplitude = abs(d)/ampFac;

[amplitude,frequency] = sort(amplitude(1:floor((end+1)/2)),'descend');

phase = angle(d(frequency));

frequency = (frequency-1)/2;

end

