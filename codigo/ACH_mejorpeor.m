function [camino,costo_MejorGlobal,t,epocas]=ACH_mejorpeor(X,inicio,fin,nro_hormigas,p,epomax,f_ini,alfa,beta)
    %DESCRIPCION: Se aporta feromona extra al mejor camino, y se castiga a la peor hormiga disminuyendo feromona de su camino. Se realiza tmb
    %una mutacion en las feromonas para evitar estancamiento en una solucion(global o local) y aumentar las chances de encontrar la mejor
    %solucion.
    %%%
    %ENTRADAS:
    %X: matriz de adyacencia. cada arco(fila i, columna j) tiene el costo
    %inicio: nodo raiz (hormiguero)
    %fin: meta
    %nro_hormigas: cantidad de hormigas para realizar el experimento
    %p: ratio de evaporacion de feromona entre [0,1]
    %ep: constante para la evaporacion de la peor solucion (parametro exclusivo de MEJOR-PEOR Hormiga)
    %%%
    %SALIDAS:
    %L=lista que contiene la secuencia de nodos optima
    %costo: distancia total del inicio al fin
    
    tic();
    [n,m]=size(X);
    F=f_ini+sparse(n,m);%matriz de feromona. Indica por cada arco entre 2 nodos, la cantidad de feromona depositada
    rutas=cell(nro_hormigas,1); %caminos realizados por cada hormiga
    distancias=zeros(1,nro_hormigas); %sirve para ordenar las soluciones de mejor a peor y tambien para averiguar cuantas hormigas siguen el mismo camino
    threshold=0; %se usa como parametro en el calculo de mutacion
    ITr=0; %se usa como parametro en el calculo de mutacion
    
    costo_MejorGlobal=inf;
    val=inf;
    rep=0; %analiza la mejor solucion de una hormiga contra las demas. si durante 3 etapas la mayoria de las hormigas
    %no siguen esta solucion optima, se considera que el algoritmo se ha estancado y se resetean los
    %rastros de feromonas.
    epocas=0;
    contador=0;
    while( contador<nro_hormigas )
        for h=1:nro_hormigas %cada hormiga hace su recorrido
            rutas{h}=solucion_hormiga_mejorpeor(X,F,inicio,fin,alfa,beta);
            distancias(h)=rutas{h}(end);
        end
        
        %evaporacion feromona a nivel global
        F=(1-p).*F;
        
        %ordenar resultados para encontrar la mejor y peor hormiga
        [~,indx]=sort(distancias);
        costo_MejorGlobal=rutas{indx(1)}(end);
        
        %depositar feromona en el camino de las 2 mejores hormigas
        for best=1:2
            if(rutas{indx(best)}(end)~=inf)
                for i=1:length(rutas{indx(best)})-2
                    F(rutas{indx(best)}(i+1),rutas{indx(best)}(i))=F(rutas{indx(best)}(i+1),rutas{indx(best)}(i)) + p*(1/rutas{indx(best)}(end));
                    if(best==1) threshold=threshold+F(rutas{indx(best)}(i+1),rutas{indx(best)}(i));
                    end
                end
            end
        end
        
        %evaporar feromona en el camino de la peor hormiga
        worst = indx(end);
        for i=1:length(rutas{worst})-2
            [~,concec]=ismember([rutas{worst}(i) rutas{worst}(i+1)],rutas{indx(1)});
            if( concec(2)-concec(1)~=1 ) %las aristas de la peor hormiga no deben coincidir con las aristas de la mejor hormiga
                F(rutas{worst}(i+1),rutas{worst}(i))=(1-p)*F(rutas{worst}(i+1),rutas{worst}(i));
            end
        end
        
        %mutacion de feromonas
        threshold=threshold/(length(rutas{indx(1)})-2);
        for j=2:nro_hormigas-1
            for i=1:length(rutas{indx(j)})-2
                mutacion=((epocas-ITr)/(epomax-ITr))*rand*threshold;
                a=randi([0,1]);
                if(a==0)
                    F(rutas{indx(j)}(i+1),rutas{indx(j)}(i)) = F(rutas{indx(j)}(i+1),rutas{indx(j)}(i)) + mutacion;
                else
                    F(rutas{indx(j)}(i+1),rutas{indx(j)}(i)) = F(rutas{indx(j)}(i+1),rutas{indx(j)}(i)) - mutacion;
                    if(F(rutas{indx(j)}(i+1),rutas{indx(j)}(i))<0)
                        F(rutas{indx(j)}(i+1),rutas{indx(j)}(i))=0;
                    end
                end
            end
        end
        
        %analizar criterio de corte de algoritmo
        distancias=distancias(distancias~=inf); %caminos de hormigas que se pierden no cuentan
        if(~isempty(distancias))
            [val,contador]=mode(distancias); %cual es el camino mas seguido por las hormigas (y cuantas hormigas lo hacen)
        end
        
        if(val~=costo_MejorGlobal)
            rep=rep+1;
        else
            rep=0;
        end
        if(rep==8 || epocas==epomax)
            ITr=epocas;
            contador=0;
            F=f_ini+sparse(n,m);
            %depositar feromona en el camino de la mejor hormiga
            for i=1:length(rutas{indx(1)})-2
                F(rutas{indx(1)}(i+1),rutas{indx(1)}(i))=F(rutas{indx(1)}(i+1),rutas{indx(1)}(i)) + p*(1/rutas{indx(1)}(end));
            end
        end
        
        epocas=epocas+1;
    end
    
    %devolver la ruta optima
    camino=rutas{1}(1:end-1);
    costo_MejorGlobal=rutas{1}(end);
    t=toc();
    
end
