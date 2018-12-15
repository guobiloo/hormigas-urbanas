function [L] = solucion_hormiga_MAXMIN(X,F,inicio,fin,q0,alfa,beta)
    %%%%
    %ENTRADAS:
    %X: matriz de adyacencia. cada arco(fila i, columna j) tiene el costo
    %inicio: nodo raiz (hormiguero)
    %fin: nodo destino (comida)
    %nro_hormigas: cantidad de hormigas para realizar el experimento
    %p: ratio de evaporacion de feromona entre [0,1]
    %f_ini: nivel de feromona inicial en todos los arcos
    %rho: ratio de evaporacion de feromona LOCAL entre [0,1]. (parametro exclusivo de ACS)
    %q0: parametro aleatorio de transicion de estados entre [0,1]. (parametro exclusivo de ACS)
    %alfa y beta: alfa=0, dar importancia a funcion heuristica. beta=0 dar importancia solo a los rastros de feromona en el camino.
    %%%%
    %SALIDAS:
    %camino=lista que contiene la secuencia de nodos optima
    %costo: distancia total del inicio al fin
    
    L=inicio; %L es un vector que va almacenando los nodos. Cuando explota un nodo, lo ubica al inicio de la lista
    
    while(L(1)~=fin) %se recorren los nodos hasta encontrar la primera solucion valida
        nodo_actual=L(1);
        indx=find(X(nodo_actual,:)~=0); %quienes son los nodos vecinos al actual
        indx=indx( ~ismember(indx,L) ); %no elegir nodos que ya se visito
        if(isempty(indx))
            L=[L inf]; %la hormiga se perdio. Cortar con la busqueda
            break;
        end
        
        q=rand;
        if(q<=q0) %eleccion probabilistica del siguiente nodo (propuesto por Ant Colony System ACS)
            Z=(F(nodo_actual,indx).^alfa).*((1./X(nodo_actual,indx)).^beta);
            [~,r]=max(Z);
            L=[indx(r) L];
        else
            suma=(F(nodo_actual,indx).^alfa) * ((1./X(nodo_actual,indx)).^beta)';
            Z=((F(nodo_actual,indx).^alfa) .* ((1./X(nodo_actual,indx)).^beta)) ./ suma;
            r=rueda_ruleta_aux(Z); %la hormiga avanza al siguiente nodo en base a una probabilidad dada por la cantidad de feromona en cada arista.
            L=[indx(r) L];
        end
        
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