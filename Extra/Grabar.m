Fs=8000;
recObj = audiorecorder(Fs,16,1);
disp('Start speaking.')
recordblocking(recObj, 5);
disp('End of Recording.');
y = getaudiodata(recObj);

L=length(y);
NFFT = 2^nextpow2(L);
Y = fft(y,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
e=2*abs(Y(1:NFFT/2+1));
[pks,locs]=findpeaks(e,f,'MinPeakHeight',0.0025,'MinPeakDistance',500)
figure(1)
findpeaks(e,f,'MinPeakHeight',0.0025,'MinPeakDistance',500);
text(locs+.02,pks,num2str((1:numel(pks))'))

audiowrite('Sonidos/Las/Las7.wav',y,Fs)