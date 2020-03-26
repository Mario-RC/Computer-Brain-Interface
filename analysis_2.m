% Analisis 2

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

% Media de la actividad neuronal para un mismo objetivo
direcciones = {'der';'arriba_der';'arriba';'arriba_izq';'izq';'abajo_izq';'abajo';'abajo_der'};

% Crear el filtro Gaussiano
sigma = 2; % valor se sigma para el gaussiano
gaussFilter = gausswin(7*sigma + 1);
gaussFilter = gaussFilter/sum(gaussFilter); % normalizar

figure
for i = 1:numel(direcciones)
    
    % Media según el objetivo en el marco de tiempo establecido
    [media.(direcciones{i})] = media_direcciones(idx.(direcciones{i}),trial_data,start,finish);
    
    % Convolucion de la actividad media de cada neurona
    for j = 1:size(media.(direcciones{i}),2)
        convolucion.(direcciones{i})(:,j) = conv(media.(direcciones{i})(:,j), gaussFilter, 'same');
    end
    
    % Neuronas mas representativas: 37, 40, 73
    Neruona37 = convolucion.(direcciones{i})(:,37);
    Neruona40 = convolucion.(direcciones{i})(:,40);
    Neruona73 = convolucion.(direcciones{i})(:,73);
    
    % Plot firing rates
    t37 = 1:1:size(Neruona37,1);
    t40 = 1:1:size(Neruona40,1);
    t73 = 1:1:size(Neruona73,1);
    subplot(4,2,i)
    plot(t37,Neruona37,'r','LineWidth',1); hold on
    plot(t40,Neruona40,'b','LineWidth',1); hold on
    plot(t73,Neruona73,'g','LineWidth',1); hold off
    xlabel('Tiempo')
    ylabel('Actividad neuronal')
    axis([0 25 0 5])
    if i == 1
        legend('Neurona 37','Neurona 40','Neurona 73','Location','NE')
        title('Dirección derecha')
    elseif i == 2
        title('Dirección arriba derecha')
    elseif i == 3
        title('Dirección arriba')
    elseif i == 4
        title('Dirección arriba izquierda')
    elseif i == 5
        title('Dirección izquierda')
    elseif i == 6
        title('Dirección abajo izquierda')
    elseif i == 7
        title('Dirección abajo')
    elseif i == 8
        title('Dirección abajo derecha')
    end
    
end
