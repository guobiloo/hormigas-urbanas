function [coles] = carga_paradas()
    
    %el colectivo hace el recorrido de izq->derecha como se van ubicando los nodos en el vector
    
    %Linea 14
    coles(1).NumeroLinea=14;
    coles(1).recorrido=[190,469,226,187,238,90,58,25];

    %Linea 8
    coles(2).NumeroLinea=8;
    coles(2).recorrido=[107,91,145,100,272,344,322,357,388,360,294];

   %Linea 14 (mapa grande)
%     coles(1).NumeroLinea=14;
%     coles(1).recorrido=[1451,1046,1531,1039,777,245,213,206,195];
end