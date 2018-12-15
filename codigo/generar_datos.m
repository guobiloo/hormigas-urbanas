function [] = generar_datos(cant_datos,M,M2,paradaSubida,paradaBajada,inicio,destino)
    
    f_ini=0.2; %nivel de feromona inicial en el grafo
    f_max=1;
    epomax=300;
    p=0.6; %nivel de evaporacion de feromona
    cantidad_hormigas=8;
    rho=0.6;
    q0=0.3;
    alfa=1;
    beta=0;
    
    
    D1=zeros(cant_datos,3);
    D2=zeros(cant_datos,3);
    D3=zeros(cant_datos,3);
    D4=zeros(cant_datos,3);
    
    
    for i=1:cant_datos
        %RUTA MINIMA CON ALGORITMOS DE HORMIGAS
        start = inicio;
        target = paradaSubida;
        [r1, dist1,t1,epo1]=ACH(M,start,target,cantidad_hormigas,p,f_ini,alfa,beta);
        
        start = paradaSubida;
        target = paradaBajada;
        [r2, dist2,t2,epo2]=ACH(M2,start,target,cantidad_hormigas,p,f_ini,alfa,beta);
        
        start = paradaBajada;
        target = destino;
        [r3, dist3,t3,epo3]=ACH(M,start,target,cantidad_hormigas,p,f_ini,alfa,beta);
        
        D1(i,:)=[dist1+dist2+dist3, t1+t2+t3, epo1+epo2+epo3];
        
        
        %RUTA MINIMA CON SISTEMA DE COLONIA DE HORMIGAS
        start = inicio;
        target = paradaSubida;
        [r1, dist1,t1,epo1]=ACS(M,start,target,cantidad_hormigas,p,rho,q0,epomax,f_ini,alfa,beta);
        
        start = paradaSubida;
        target = paradaBajada;
        [r2, dist2,t2,epo2]=ACS(M2,start,target,cantidad_hormigas,p,rho,q0,epomax,f_ini,alfa,beta);
        
        start = paradaBajada;
        target = destino;
        [r3, dist3,t3,epo3]=ACS(M,start,target,cantidad_hormigas,p,rho,q0,epomax,f_ini,alfa,beta);
        
        D2(i,:)=[dist1+dist2+dist3, t1+t2+t3, epo1+epo2+epo3];
        
        % RUTA MINIMA CON HORMIGAS MAX MIN
        %         start = inicio;
        %         target = paradaSubida;
        %         [r1, dist1,t1,epo1]=ACS_MAXMIN(M,start,target,cantidad_hormigas,p,q0,epomax,f_ini,f_max,alfa,beta);
        %
        %         start = paradaSubida;
        %         target = paradaBajada;
        %         [r2, dist2,t2,epo2]=ACS_MAXMIN(M2,start,target,cantidad_hormigas,p,q0,epomax,f_ini,f_max,alfa,beta);
        %
        %         start = paradaBajada;
        %         target = destino;
        %         [r3, dist3,t3,epo3]=ACS_MAXMIN(M,start,target,cantidad_hormigas,p,q0,epomax,f_ini,f_max,alfa,beta);
        %
        %         D3(i,:)=[dist1+dist2+dist3, t1+t2+t3, epo1+epo2+epo3];
        
        % RUTA MINIMA CON MEJOR-PEOR HORMIGA
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
    
    csvwrite('ACH--p-0.6---hormigas-8.csv',D1);
    csvwrite('ACS--p-0.6---hormigas-8.csv',D2);
    %         csvwrite('MAXMIN--p-0.6---hormigas-8.csv',D3);
    csvwrite('MEJORPEOR--p-0.6---hormigas-8.csv',D4);
end