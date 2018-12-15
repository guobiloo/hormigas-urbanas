function [camino,costo_MejorGlobal,t,epocas]=ACS_MAXMIN(X,inicio,fin,nro_hormigas,p,q0,epomax,f_ini,f_max,alfa,beta)
    %%SISTEMA DE  DE HORMIGAS MAX-MIN
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
    
    tic();
    [n,m]=size(X);
    F=f_max+sparse(n,m);%matriz de feromona. Indica por cada arista o conexion entre 2 nodos, la cantidad de feromona depositada
    rutas=cell(nro_hormigas,1); %caminos realizados por cada hormiga
    distancias=zeros(1,nro_hormigas); %sirve para ordenar las soluciones de mejor a peor y tambien para averiguar cuantas hormigas siguen el mismo camino
    
    epocas=0;
    contador=0;
    while( contador<nro_hormigas )
        
        %cada hormiga hace su recorrido
        for h=1:nro_hormigas
            rutas{h}=solucion_hormiga_MAXMIN(X,F,inicio,fin,q0,alfa,beta);
            distancias(h)=rutas{h}(end);
            
            %evaporacion y deposicion online de feromona (propuesto por ACS)
            for i=1:length(rutas{h})-2
                F(rutas{h}(i+1),rutas{h}(i)) = F(rutas{h}(i+1),rutas{h}(i)) + (p*f_ini);
            end
        end
        
        %evaporacion feromona a nivel global
        F=-0.1+(1-p).*F;
        
        %ordenar resultados para encontrar la mejor y peor hormiga
        [~,indx]=sort(distancias);
        
        %calcular maxima cantidad de feromona admitido
        if(rutas{indx(1)}(end)~=inf)
            f_max=p*rutas{indx(1)}(end);
        end
        
        %depositar feromona en el camino de las 3 mejores hormigas
        for best=1:3
            if(rutas{indx(best)}(end)~=inf)
                for i=1:length(rutas{indx(best)})-2
                    F(rutas{indx(best)}(i+1),rutas{indx(best)}(i))=F(rutas{indx(best)}(i+1),rutas{indx(best)}(i)) + p*(1/rutas{indx(best)}(end));
                end
            end
        end
        
        %mantener un nivel minimo y maximo de feromona en todo el grafo
        indx=find(F<f_ini);
        F(indx)=f_ini;
        indx=find(F>f_max);
        F(indx)=f_max;
        
        %analizar criterio de corte de algoritmo
        distancias=distancias(distancias~=inf); %caminos de hormigas que se pierden no cuentan
        if(~isempty(distancias))
            [~,contador]=mode(distancias); %cual es el camino mas seguido por las hormigas (y cuantas hormigas lo hacen)
        end
        
        %corregir condiciones de estancamiento
        if(epocas==epomax)
            F=f_max+sparse(n,m);
            epomax=epomax*2;
        end
        
        epocas=epocas+1;
    end
    
    
    %devolver la ruta optima
    camino=rutas{1}(1:end-1);
    costo_MejorGlobal=rutas{1}(end);
    t=toc();

end