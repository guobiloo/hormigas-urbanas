function [camino,costo_MejorGlobal,t,epocas]=ACH(X,inicio,fin,nro_hormigas,p,f_ini,alfa,beta)
    %%COLONIA DE HORMIGAS SIMPLE
    %%%%
    %ENTRADAS:
    %X: matriz de adyacencia. cada arco(fila i, columna j) tiene el costo
    %inicio: nodo raiz (hormiguero)
    %fin: nodo destino (comida)
    %nro_hormigas: cantidad de hormigas para realizar el experimento
    %p: ratio de evaporacion de feromona entre [0,1]
    %f_ini: nivel de feromona inicial en todos los arcos
    %alfa y beta: alfa=0, dar importancia a funcion heuristica. beta=0 dar importancia solo a los rastros de feromona en el camino.
    %%%%
    %SALIDAS:
    %L=lista que contiene la secuencia de nodos optima
    %costo: costo total del camino optimo encontrado
    %t: tiempo de resolucion del problema
    
    tic();
    [n,m]=size(X);
    F=f_ini+sparse(n,m); %matriz de feromona. Indica por cada arco entre 2 nodos, la cantidad de feromona depositada
    rutas=cell(nro_hormigas,1); %caminos realizados por cada hormiga, que contiene como ultimo valor de la lista, el costo o distancia recorrida
    distancias=zeros(nro_hormigas,1); %sirve para ordenar las soluciones de mejor a peor y tambien para averiguar cuantas hormigas siguen el mismo camino
    
    epocas=0;
    contador=0;
    while( contador<nro_hormigas )
        %cada hormiga hace su recorrido
        for h=1:nro_hormigas
            rutas{h}=solucion_hormiga_ACH(X,F,inicio,fin,alfa,beta);
            distancias(h)=rutas{h}(end); %ultimo valor del camino recorrido, es el coste total del camino hallado
        end
        
        %evaporacion feromona a nivel global
        F=(1-p).*F;
        
        %depositar feromona global
        for h=1:nro_hormigas
            if( distancias(h)~=inf )
                for i=1:length(rutas{h})-2
                    F(rutas{h}(i+1),rutas{h}(i)) = F(rutas{h}(i+1),rutas{h}(i)) + (1/distancias(h));
                end
            end
        end
        
        %analizar criterio de corte de algoritmo
        distancias=distancias(distancias~=inf); %caminos de hormigas que se pierden no cuentan
        if(~isempty(distancias))
            [~,contador]=mode(distancias); %cual es el camino mas seguido por las hormigas (y cuantas hormigas lo hacen)
        end
        epocas=epocas+1;
    end
    
    %devolver la ruta optima
    camino=rutas{1}(1:end-1);
    costo_MejorGlobal=rutas{1}(end);
    t=toc();
    
end