[y,Fs]=audioread('Sonidos/Las/Las7.wav');    %set(handles.text1,'String','Leyendo audio');
%FFT de la señal
L=length(y);
NFFT = 2^nextpow2(L);
Y = fft(y,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
e=2*abs(Y(1:NFFT/2+1));
% figure(1)
% plot(f,e)
%Encontrar los picos
[pks,locs]=findpeaks(e,f,'MinPeakHeight',0.0025,'MinPeakDistance',100)
% figure(2)
% findpeaks(e,f,'MinPeakHeight',0.0025,'MinPeakDistance',100);
% text(locs+.02,pks,num2str((1:numel(pks))'))
