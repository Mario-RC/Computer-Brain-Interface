% Analisis 5

clear all
close all
clc

addpath('./functions');
load center_out_data

% Separa cada repetición según la dirección objetivo
[idx] = Todos_intentos([trial_data.target_direction]); 

% Halla los bins incial y final del marco para cada ejecucion
[start,finish] = marco(trial_data);

% Media de la actividad neuronal para un mismo objetivo
direcciones = {'der';'arriba_der';'arriba';'arriba_izq';'izq';'abajo_izq';'abajo';'abajo_der'};

for i = 1:9 % Coger 9 Neuronas aleatorias
    rng('shuffle')
    trial_number(i,1) = randi([1 84]);
end

figure
for k = 1:size(trial_number,1)
    
    subplot(5,2,k)
    for i = 1:numel(direcciones)
        % Media de la actividad neuronal (mna) según el objetivo en el marco de
        % tiempo establecido
        [media.(direcciones{i})] = media_direcciones(idx.(direcciones{i}),trial_data,start,finish);
        
        % Impresion del raster de la actividad neuronal media
        angulo(i,1) = rad2deg(trial_data(idx.(direcciones{i})(1)).target_direction);
        media_neuronal(i,1) = mean(media.(direcciones{i})(:,trial_number(k)))*20;
    end
    
    % Fitear los puntos de activacion neuronal con una regresion senoidal
    f = fit(angulo,media_neuronal,'sin2');
    plot(f,angulo,media_neuronal,'*'); hold all;
    
    if k == 1
        legend('Impulso medio/segundo','Fit senoidal','Error bar','Location','NE')
    else
        % Borrar leyenda
        hLeg = legend('');
        set(hLeg,'visible','off')
    end
    
    xlabel('Dirección del movimiento (grados)')
    ylabel('Impulsos/s')
    axis([-150 200 -inf inf]);
    xticks([-135 -90 -45 0 45 90 135 180])
    title(['Neurona ',num2str(trial_number(k))])
    
end
