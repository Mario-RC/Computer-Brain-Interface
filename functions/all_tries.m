
function [idx] = Todos_intentos(direcciones)

direcciones = direcciones';

idx.der = [];
idx.arriba_der = [];
idx.arriba = [];
idx.arriba_izq = [];
idx.izq = [];
idx.abajo_izq = [];
idx.abajo = [];
idx.abajo_der = [];

for k = 1:size(direcciones)
    
    if (direcciones(k) == 0)
        idx.der(size(idx.der,2)+1) = k;
        
    elseif (round(direcciones(k),2) == 0.79)
        idx.arriba_der(size(idx.arriba_der,2)+1) = k;
        
    elseif (round(direcciones(k),2) == 1.57)
        idx.arriba(size(idx.arriba,2)+1) = k;
        
    elseif (round(direcciones(k),2) == 2.36)
        idx.arriba_izq(size(idx.arriba_izq,2)+1) = k;
        
    elseif (round(direcciones(k),2) == 3.14)
        idx.izq(size(idx.izq,2)+1) = k;
        
    elseif (round(direcciones(k),2) == -2.36)
        idx.abajo_izq(size(idx.abajo_izq,2)+1) = k;
        
    elseif (round(direcciones(k),2) == -1.57)
        idx.abajo(size(idx.abajo,2)+1) = k;
        
    elseif (round(direcciones(k),2) == -0.79)
        idx.abajo_der(size(idx.abajo_der,2)+1) = k;
    end
end

idx.der = idx.der';
idx.arriba_der = idx.arriba_der';
idx.arriba = idx.arriba';
idx.arriba_izq = idx.arriba_izq';
idx.izq = idx.izq';
idx.abajo_izq = idx.abajo_izq';
idx.abajo = idx.abajo';
idx.abajo_der = idx.abajo_der';

end
