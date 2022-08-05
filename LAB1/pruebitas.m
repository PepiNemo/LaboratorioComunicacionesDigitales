fc=1000; %Frecuencia de la sinusoidal
fm=100000; %Frecuencia de muestreo 1/1e5Hz
fs=600;   %Frecuencia de la cuadrada
t=0:1/fm:5/fc;% tiempo muestrado a 1e5 HZ, por 5 periodos de sinusoidal
d=1.5e-1*fs; %(tau / Ts) <=> (tau *fs   ) 
mt=cos(2*pi*fc*t); %Onda analogica sinusoidal
ct=0.5*square(2*pi*fs*t,d)+0.5;%Forma de onda de conmutación de ondas rectangulares
st=mt.*ct;
figure(1)
subplot(1,1,1); plot(t,mt); title('señal de mensaje'); xlabel('T'); ylabel('amplitud');

st1 = st;
figure(2)
subplot(2,2,1); plot(t,mt); title('señal de mensaje'); xlabel('T'); ylabel('amplitud');
subplot(2,2,2); plot(t,ct); title('Onda de conmutación de ondas rectangulares'); xlabel('T'); ylabel('amplitud');
subplot(2,2,3); plot(t,st1); title('PAM muestreo natural'); xlabel('T'); ylabel('amplitud');



%%%%%%%%%%%%%%%%%%%%%%%  PAM muestreo instantaneo %%%%%%%%%%%%%%%%%%%%
for i = 2: length(t)
    if ct(i) == 1 && ct(i-1) == 0 %if the rising edge is detect_encoding    
        st(i) = ct(i) * mt(i); %sampling occurs
    elseif ct(i) == 1 && ct(i-1) == 1 %and while the carrier signal is 1
        st(i) = st(i-1); %the value of y1 remains constant
    else 
        st(i) = 0; %otherwise, st is zero
    end
end

figure(3)
subplot(2,1,1); plot(t,mt); title('señal de mensaje'); xlabel('T'); ylabel('amplitud');
subplot(2,1,2); plot(t,st); xlabel('T'); ylabel('Amplitud'); title('PAM Muestreo instantaneo')

figure(4)
subplot(2,2,1); plot(t,mt); title('señal de mensaje'); xlabel('T'); ylabel('amplitud');
subplot(2,2,2); plot(t,ct); title('Onda de conmutación de ondas rectangulares'); xlabel('T'); ylabel('amplitud');
subplot(2,2,3); plot(t,st1); title('PAM muestreo natural'); xlabel('T'); ylabel('amplitud');
subplot(2,2,4); plot(t,st); xlabel('T'); ylabel('Amplitud'); title('PAM Muestreo instantaneo')