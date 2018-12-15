function [L] = solucion_hormiga_mejorpeor(X,F,inicio,fin,alfa,beta)
    %%%
    %ENTRADAS:
    %X: matriz de adyacencia. cada arco(fila i, columna j) tiene el costo
    %F: matriz de feromonas de cada arista
    %inicio: nodo raiz (hormiguero)
    %fin: meta
    %alfa y beta: ponderan la importancia de la heurística utilizada y los valores de feromona detectados.
    %%%
    %SALIDAS:
    %L=solucion (camino) de la hormiga en particular
    
    
    L=inicio;
    
    while(L(1)~=fin) %se recorren los nodos hasta encontrar la primera solucion valida
        nodo_actual=L(1);
        indx=find(X(nodo_actual,:)~=0); %quienes son los nodos vecinos al actual
        indx=indx( ~ismember(indx,L) ); %no elegir nodos que ya se visito
        if(isempty(indx))
            L=[L inf]; %la hormiga se perdio.Cortar con la busqueda
            break;
        end
        suma=(F(nodo_actual,indx).^alfa) * ((1./X(nodo_actual,indx)).^beta)';
        Z=((F(nodo_actual,indx).^alfa) .* ((1./X(nodo_actual,indx)).^beta)) ./ suma;
        r=rueda_ruleta_aux(Z); %la hormiga avanza al siguiente nodo en base a una probabilidad dada por la cantidad de feromona en cada arista.
        L=[indx(r) L];
    end
    
    if(L(end)~=inf) %si la hormiga no se perdio, devolver el camino y calcular los costos incurridos
        %calculo el costo total incurrido para este camino hallado
        costo_total=0;
        for i=1:length(L)-1
            costo_total = costo_total + X(L(i+1),L(i));
        end
        L=[L costo_total];
    end
end