# hormigas-urbanas
Trazo de ruta sobre un mapa de santa fe desde un punto de origen hasta un destino, utilizando colectivos públicos.

En la actualidad existen algunos servicios que permiten visualizar mapas y planear rutas considerando
el uso de transportes urbanos en una ciudad. Se propone aquí el uso de métodos de Inteligencia Colectiva inspirados en el comportamiento de hormigas. El objetivo será comparar los distintos métodos de implementación de colonia de hormigas, seleccionar la
alternativa metódica mas adecuada y estudiar su comportamiento en base a variaciones en sus parámetros característicos.

# contacto
Ante cualquier duda, consulte por mail:
joa_gzb@hotmail.com

# Dependencias
El proyecto pudo realizarse gracias a la librería openstreetmap que permitió rápidamente copiar un mapa de la página web de OpenStreetMap y plotearlo en matlab, considerando las conectividades entre nodos (como las esquinas).
Por favor, visite la librería en el siguiente link para mas información:
https://github.com/johnyf/openstreetmap

# ejecución
Para correr el proyecto, ejecute el script TPF.m

Dentro del script hay una sección llamada "RUTA MINIMA CON SISTEMA DE COLONIA DE HORMIGAS", el cual tiene los distintos métodos de hormigas (AS,sACO,MMAX,BWAS). Puede ir probando cada uno de los métodos solo considerando uno a la vez. Esto es así porque no se ha programado que todos los métodos se hagan de forma separada en distintas gráficas.

# Problemas
el algorimo de sistema de hormigas MAX-MIN (MMAS) no funciona bien y puede tardar en encontrar una solución como estancarse.
