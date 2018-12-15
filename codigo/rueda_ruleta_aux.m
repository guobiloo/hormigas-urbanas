function pos = rueda_ruleta_aux(Z)
    %%arma un vector de 100 componentes, donde cada posicion lleva el numero de una
    %clase. El tamano del vector Z (que contiene probabilidades) dice cuantas clases
    %hay, y cada probabilidad indica cuantas posiciones en el vector de 100 se reservarán
    %para una clase.
    %Importante: la suma de las probabilidades del vector de Z deben sumar 1.
    
    aux=[];
    for i=1:length(Z)
        aux=[aux linspace(i,i,round(100*Z(i)))];
    end
    if(length(aux)<100)
       aux=[aux linspace(1,1,100-length(aux))]; 
    end
    if(length(aux)>100)
        aux=aux(1:100);
    end
    aux=aux(randperm(100));
    
    pos=aux(randi(100));
end