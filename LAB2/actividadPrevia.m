clear all

fo=1000;
T=1/fo;
fs = fo*10;
Ts=1/fs;
t=[-3*T:Ts:3*T];
%Muestras para un periodo T
m=T/Ts;
%Tren de pulsos de distancia Ts
valores=(2*randi([0,1],[1,10^2]))-1;
%Onda cajon con periodo T
RECt=t;
for index = 1 : length(RECt) 
    if(length(RECt)/2)- (m/2) <=index  && index<=(length(RECt)/2)+(m/2)
        RECt(index)=1;
    else
        RECt(index)=0;
    end
end


%TrenPulsos=upsample(valores, Ts)
%figure
%plot(UPsampleValores)

% defining the sinc filter, SA function
sincNum = sin(2*pi*fo*t); % numerator sinc function
sincDen = (2*pi*fo*t); % denominator of the sinc function
sincDenZero = find(abs(sincDen) < 10^-10);
sincOp = sincNum./sincDen;
sincOp(sincDenZero) = 1; % sin(pix/(pix) =1 for x =0

alpha = input("alpha");%alpha=f tri / fo => alpha*fo*t = ftri * t
cosNum = cos(2*pi*alpha*fo*t);%2pi f-tri t <=> 2*pi*alpha*fo*t
cosDen = (1-(4*alpha*fo*t).^2);
cosDenZero = find(abs(cosDen)< 10^-10);
cosOp = cosNum./cosDen;
cosOp(cosDenZero) = pi/4;

%gt Respuesta impulso equivalente
gt_alpha0 = 2*fo*sincOp.*cosOp;
%GT respuesta impulso equivalente en frecuencia.
GF_alpha0 = fft(gt_alpha0);

%secuencia filtrada con el SA
st_alpha=conv(valores, gt_alpha0)

close all
figure
plot(t, RECt)
xlabel('Señal cajon')
plot(conv(valores , RECt))
xlabel('convolucion')
%plot(st_alpha)

%close all
figure
plot(t,[gt_alpha0],'b','LineWidth',2)
%plot([gt_alpha0])
xlabel('time, t')
ylabel('amplitude, g(t)')
title('Time domain waveform of raised cosine pulse shaping filters')

figure
%plot([-512:511]/1024*fs, abs(fftshift(GF_alpha0)),'b','LineWidth',2);
%
plot( abs(fftshift(GF_alpha0)),'b','LineWidth',2)
%plot(magTFgt, f1a)
hold on

%axis([-2 2 0 14])
grid on
xlabel('frequency, f')
ylabel('amplitude, |G(f)|')
title('Frequency domain representation of raised cosine pulse shaping filters')