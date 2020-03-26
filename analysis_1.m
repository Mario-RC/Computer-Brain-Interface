% Analisis 1

clear all
close all
clc

addpath('./functions')
load center_out_data

% Separa cada repetición según la dirección objetivo
[idx] = Todos_intentos([trial_data.target_direction]); 
[idxs] = Intentar_seleccion([trial_data.target_direction]);

% Halla los bins incial y final del marco para cada ejecucion
[start,finish] = marco(trial_data);

% Media de la actividad neuronal para un mismo objetivo
direcciones = {'der';'arriba_der';'arriba';'arriba_izq';'izq';'abajo_izq';'abajo';'abajo_der'};

% Crear el filtro Gaussiano
sigma = 2; % valor se sigma para el gaussiano
gaussFilter = gausswin(7*sigma + 1);
gaussFilter = gaussFilter/sum(gaussFilter); % normalizar

for i = 1:numel(direcciones)
    
    figure(1)
    % Media según el objetivo en el marco de tiempo establecido
    [media.(direcciones{i})] = media_direcciones(idx.(direcciones{i}),trial_data,start,finish);
    
    % Convolución de la actividad media de cada neurona
    for j = 1:size(media.(direcciones{i}),2)
        convolucion(:,j) = conv(media.(direcciones{i})(:,j), gaussFilter, 'same');
    end
    
    % Impresión del raster de la actividad neuronal media convolucionada
    subtightplot(1,9,i)
    convolucion = convolucion';
    colormap('hot')
    imagesc(convolucion)
    axis off
    clear convolucion
    
end

for i = 1:size(idxs,2)
    
    figure(2)
    subtightplot(1,8,i)
    t = (1:1:length(trial_data(idxs(i)).vel))';
    vx = trial_data(idxs(i)).vel(:,1);
    vy = trial_data(idxs(i)).vel(:,2);

    t = t(50:end);
    vx = vx(50:end);
    vy = vy(50:end);

    plot(t,smooth(vx),'LineWidth',2); hold on
    plot(t,smooth(vy),'LineWidth',2); hold off
    axis([50 100 -30 30])
    axis off
    
end

legend('X vel','Y vel')

figure(1)
subtightplot(1,9,9)
colorbar
axis off
