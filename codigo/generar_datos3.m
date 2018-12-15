function [] = generar_datos3(cant_datos,M,M2,paradaSubida,paradaBajada,inicio,destino)
    
    f_ini=0.4; %nivel de feromona inicial en el grafo
    epomax=400;
    p=0.7; %nivel de evaporacion de feromona
    cantidad_hormigas=15;
    inicio = 374;
    destino = 94;
    alfa=1;
    beta=1;
    
    
    D4=zeros(30,3);
    
    
    for i=1:30
        
        
        start = inicio;
        target = paradaSubida;
        [r1, dist1,t1,epo1]=ACH_mejorpeor(M,start,target,cantidad_hormigas,p,epomax,f_ini,alfa,beta);
        
        start = paradaSubida;
        target = paradaBajada;
        [r2, dist2,t2,epo2]=ACH_mejorpeor(M2,start,target,cantidad_hormigas,p,epomax,f_ini,alfa,beta);
        
        start = paradaBajada;
        target = destino;
        [r3, dist3,t3,epo3]=ACH_mejorpeor(M,start,target,cantidad_hormigas,p,epomax,f_ini,alfa,beta);
        
        D4(i,:)=[dist1+dist2+dist3, t1+t2+t3, epo1+epo2+epo3];
        
        disp('datos generados:')
        i
        
        
    end
    
    
    csvwrite('MEJORPEOR--FINAL.csv',D4);
end