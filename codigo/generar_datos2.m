function [] = generar_datos2(cant_datos,M,M2,paradaSubida,paradaBajada,inicio,destino)
    
    f_ini=0.4; %nivel de feromona inicial en el grafo
    epomax=300;
    p=0.6; %nivel de evaporacion de feromona
    cantidad_hormigas=8;
    alfa=1;
    beta=1;
    
    
    D3=zeros(110,3);
    D4=zeros(110,3);
    
    incremento_p=0.55;
    incremento_hormigas=7;
    
    for i=1:110
        if(mod(i,11)==0)
            D4(i,:)=[0, 0, 0];
            D5(i,:)=[0, 0, 0];
            incremento_p=incremento_p+0.03
            incremento_hormigas=incremento_hormigas+1
        else
            
            %% incremento de p
            
            
            start = inicio;
            target = paradaSubida;
            [r1, dist1,t1,epo1]=ACH_mejorpeor(M,start,target,cantidad_hormigas,incremento_p,epomax,f_ini,alfa,beta);
            
            start = paradaSubida;
            target = paradaBajada;
            [r2, dist2,t2,epo2]=ACH_mejorpeor(M2,start,target,cantidad_hormigas,incremento_p,epomax,f_ini,alfa,beta);
            
            start = paradaBajada;
            target = destino;
            [r3, dist3,t3,epo3]=ACH_mejorpeor(M,start,target,cantidad_hormigas,incremento_p,epomax,f_ini,alfa,beta);
            
            D4(i,:)=[dist1+dist2+dist3, t1+t2+t3, epo1+epo2+epo3];
            
            
            %% incremento de numero hormigas
            
            
            start = inicio;
            target = paradaSubida;
            [r1, dist1,t1,epo1]=ACH_mejorpeor(M,start,target,incremento_hormigas,p,epomax,f_ini,alfa,beta);
            
            start = paradaSubida;
            target = paradaBajada;
            [r2, dist2,t2,epo2]=ACH_mejorpeor(M2,start,target,incremento_hormigas,p,epomax,f_ini,alfa,beta);
            
            start = paradaBajada;
            target = destino;
            [r3, dist3,t3,epo3]=ACH_mejorpeor(M,start,target,incremento_hormigas,p,epomax,f_ini,alfa,beta);
            
            D5(i,:)=[dist1+dist2+dist3, t1+t2+t3, epo1+epo2+epo3];
            
            disp('datos generados:')
            i
            
            
        end
        
    end
    
    csvwrite('MEJORPEOR--p.csv',D4);
    csvwrite('MEJORPEOR--hormigas.csv',D5);
end