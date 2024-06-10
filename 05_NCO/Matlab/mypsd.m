
function [res, reslin, faxis] = mypsd (x, numfft, fsample_Hz, flagplot)
	
	if(size(x,1) == 1)
		x = (x.');
    end
    
    if(length(x)<numfft)
       x = [x ; zeros(numfft - length(x),1)]; 
    end
    
numtapper = floor(length(x)/numfft);
temp = zeros(numfft,1);
if numtapper > 0
	for it = 1:numtapper
      xtemp = x((it-1)*numfft+1:it*numfft);
      %xtemp = xtemp - mean(xtemp);
			temp = temp + abs(fft(hanning(numfft).*xtemp)).^2;
	end
	res = fftshift(10.*log10(temp));
	reslin = fftshift(temp);
else

	res =  fftshift(10.*log10(abs(fft(hanning(numfft).*x,numfft)).^2));
  reslin = fftshift(abs(fft(hanning(numfft).*x,numfft)).^2);
end

df = 1/numfft;
f = -0.5:df:0.5-df;
faxis = fsample_Hz.*f;
if flagplot == 1



figure
plot(fsample_Hz.*f,res);%, 'linewidth',2,'b-');

grid
xlabel('Frequency[Hz]')
ylabel('Power Spectral Density [dB]');


% # figure
% # plot(fsample_Hz.*f,reslin, 'linewidth',2);
% # 
% # grid
% # xlabel('Frequency[MHz]')
% # ylabel('PSD linear');
 end
 

