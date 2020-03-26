% Analisis 3

clear all
close all
clc

addpath('./functions')
load center_out_data

% Obtenemos los indices de mov. de cada objetivo
[idx] = Todos_intentos([trial_data.target_direction]);

% Mínimo tiempo entre mostrar el objetibo al mono y el final del experimento
% Hallamos la repetición más rápida (20 bins)
maxbin = 3;
minbin = inf;
for i = 1:size(trial_data,2)
    value = trial_data(i).idx_trial_end - trial_data(i).idx_go_cue;
    if value < minbin
        minbin = value;
        ind_min = i;
    end
end

% Restamos 3 bins de tiempo al instante de 'go cue'
start = [trial_data.idx_go_cue]' - maxbin;
% Sumamos (20) la repetición más rápida
finish = [trial_data.idx_go_cue]' + minbin;

for i = 1:9 % Coger 9 Neuronas aleatorias
    rng('shuffle')
    trial_number(i,1) = randi([1 84]);
end

% Create Gaussian filter
sigma = 2; % pick sigma value for the gaussian
gaussFilter = gausswin(7*sigma + 1);
gaussFilter = gaussFilter/sum(gaussFilter); % normalize

for i = 1:size(trial_number,1)
    % Derecha media filtrada
    suma = 0;
    for j = idx.der'
        convolucion = conv(trial_data(j).M1_spikes(start(j):finish(j),trial_number(i)), gaussFilter, 'same');
        suma = suma + convolucion;
    end
    media.der(i,:) = suma/length(idx.der);
    
    % Arriba derecha media filtrada
    suma = 0;
    for j = idx.arriba_der'
        convolucion = conv(trial_data(j).M1_spikes(start(j):finish(j),trial_number(i)), gaussFilter, 'same');
        suma = suma + convolucion;
    end
    media.arriba_der(i,:) = suma/length(idx.arriba_der);
    
    % Arriba media filtrada
    suma = 0;
    for j = idx.arriba'
        convolucion = conv(trial_data(j).M1_spikes(start(j):finish(j),trial_number(i)), gaussFilter, 'same');
        suma = suma + convolucion;
    end
    media.arriba(i,:) = suma/length(idx.arriba);
    
    % Arriba izquierda media filtrada
    suma = 0;
    for j = idx.arriba_izq'
        convolucion = conv(trial_data(j).M1_spikes(start(j):finish(j),trial_number(i)), gaussFilter, 'same');
        suma = suma + convolucion;
    end
    media.arriba_izq(i,:) = suma/length(idx.arriba_izq);
    
    % Izquierda media filtrada
    suma = 0;
    for j = idx.izq'
        convolucion = conv(trial_data(j).M1_spikes(start(j):finish(j),trial_number(i)), gaussFilter, 'same');
        suma = suma + convolucion;
    end
    media.izq(i,:) = suma/length(idx.izq);
    
    % Abajo izquierda media filtrada
    suma = 0;
    for j = idx.abajo_izq'
        convolucion = conv(trial_data(j).M1_spikes(start(j):finish(j),trial_number(i)), gaussFilter, 'same');
        suma = suma + convolucion;
    end
    media.abajo_izq(i,:) = suma/length(idx.abajo_izq);
    
    % Abajo media filtrada
    suma = 0;
    for j = idx.abajo'
        convolucion = conv(trial_data(j).M1_spikes(start(j):finish(j),trial_number(i)), gaussFilter, 'same');
        suma = suma + convolucion;
    end
    media.abajo(i,:) = suma/length(idx.abajo);
    
    % Abajo derecha media filtrada
    suma = 0;
    for j = idx.abajo_der'
        convolucion = conv(trial_data(j).M1_spikes(start(j):finish(j),trial_number(i)), gaussFilter, 'same');
        suma = suma + convolucion;
    end
    media.abajo_der(i,:) = suma/length(idx.abajo_der);   
end

t = 1:size(media.der,2);

figure
for i = 1:size(trial_number,1)
    
    subplot(5,2,i)
    plot(t,media.der(i,:),'LineWidth',1); hold on;
    plot(t,media.arriba_der(i,:),'LineWidth',1); hold on;
    plot(t,media.arriba(i,:),'LineWidth',1); hold on;
    plot(t,media.arriba_izq(i,:),'LineWidth',1); hold on;
    plot(t,media.izq(i,:),'LineWidth',1); hold on;
    plot(t,media.abajo_izq(i,:),'LineWidth',1); hold on;
    plot(t,media.abajo(i,:),'LineWidth',1); hold on;
    plot(t,media.abajo_der(i,:),'LineWidth',1); hold on;
    plot([3 3], [0 4.5], '--r','LineWidth',1); hold off;
    xlabel('Tiempo')
    ylabel('Actividad neuronal')
    title(['Neuron ',num2str(trial_number(i))])
    if i == 1
        legend('Derecha','Arriba derecha','Arriba','Arriba izquierda','Izquierda','Abajo izquierda','Abajo','Abajo derecha','go cue','Location','NW')
    end
    axis([-inf 24 -inf 2]);
    
end
