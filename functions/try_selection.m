
function [idxs] = Intentar_seleccion(direcciones)

repeticion = 1;
direcciones = direcciones';

der = 0;
arriba_der = 0;
arriba = 0;
arriba_izq = 0;
izq = 0;
abajo_izq = 0;
abajo = 0;
abajo_der = 0;

idxs = [];

resultado.der = [];
resultado.arriba_der = [];
resultado.arriba = [];
resultado.arriba_izq = [];
resultado.izq = [];
resultado.abajo_izq = [];
resultado.abajo = [];
resultado.abajo_der = [];

soluciones = 0;
revisados = [];


for k = 1:size(direcciones)
    
    if (direcciones(k) == 0 && der ~= repeticion)
        resultado.der(size(resultado.der,2)+1) = k;
        der = 1 + der;
        if (der == repeticion)
            idxs(1) = resultado.der(repeticion);            
            soluciones = 1 + soluciones;
        end
        
    elseif (round(direcciones(k),2) == 0.79 && arriba_der ~= repeticion)
        resultado.arriba_der(size(resultado.arriba_der,2)+1) = k;
        arriba_der = 1 + arriba_der;
        if (arriba_der == repeticion)
            idxs(2) = resultado.arriba_der(repeticion);            
            soluciones = 1 + soluciones;
        end
        
    elseif (round(direcciones(k),2) == 1.57 && arriba ~= repeticion)
        resultado.arriba(size(resultado.arriba,2)+1) = k;
        arriba = 1 + arriba;
        if (arriba == repeticion)
            idxs(3) = resultado.arriba(repeticion);            
            soluciones = 1+soluciones;
        end
        
    elseif (round(direcciones(k),2) == 2.36 && arriba_izq ~= repeticion)
        resultado.arriba_izq(size(resultado.arriba_izq,2)+1) = k;
        arriba_izq = 1 + arriba_izq;
        if (arriba_izq == repeticion)
            idxs(4) = resultado.arriba_izq(repeticion);            
            soluciones = 1 + soluciones;
        end
        
    elseif (round(direcciones(k),2) == 3.14 && izq ~= repeticion)
        resultado.izq(size(resultado.izq,2)+1) = k;
        izq = 1 + izq;
        if (izq == repeticion)
            idxs(5) = resultado.izq(repeticion);            
            soluciones = 1 + soluciones;
        end
        
    elseif (round(direcciones(k),2) == -2.36 && abajo_izq ~= repeticion)
        resultado.abajo_izq(size(resultado.abajo_izq,2)+1) = k;
        abajo_izq = 1 + abajo_izq;
        if (abajo_izq == repeticion)
            idxs(6) = resultado.abajo_izq(repeticion);            
            soluciones = 1 + soluciones;
        end
        
    elseif (round(direcciones(k),2) == -1.57 && abajo ~= repeticion)
        resultado.abajo(size(resultado.abajo,2)+1) = k;
        abajo = 1 + abajo;
        if (abajo == repeticion)
            idxs(7) = resultado.abajo(repeticion);            
            soluciones = 1 + soluciones;
        end
        
    elseif (round(direcciones(k),2) == -0.79 && abajo_der ~= repeticion)
        resultado.abajo_der(size(resultado.abajo_der,2)+1) = k;
        abajo_der = 1 + abajo_der;
        if (abajo_der == repeticion)
            idxs(8) = resultado.abajo_der(repeticion);            
            soluciones = 1 + soluciones;
        end
    end
    
    if (soluciones == 8)
        break
    end
end

end
