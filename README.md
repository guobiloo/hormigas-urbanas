# Hormigas-urbanas
### Problema y contexto
Es de costumbre en medianas y grandes ciudades que la gente utilice medios de transporte públicos o personales (autos, motocicletas, bicicletas) para desplazarse y poder llegar a cualquier punto.

Dependiendo del tipo de actividad que se trate, algunos puntos de la ciudad donde se concurre lleva consigo un horario establecido que se ha de respetar, como por ejemplo a la hora de trabajar. A veces, también se le suma el hecho de que no se conoce la ciudad.

Ante estos casos, la gente elige planificar los medios de transporte que debe usar, el lugar donde esperarlos y el trayecto que debe seguir. En estos campos existen soluciones de software, tales como google maps, que permite planificar el traslado así como el tiempo y el costo asociado. Estos programas traen consigo algoritmos que resuelven cómo desplazarse de un punto a otro considerando factores como tiempo, distancia y costo, entre otros. Estos algoritmos hacen uso de técnicas de búsquedas tradicionales, como costo uniforme, cuyo resultado es el mejor a considerar.

La desventaja surge cuando se trata con ciudades muy extensas, puesto que se requiere una buena gestión del flujo y estructura de datos tales como nombre de calles, números, esquinas, el tipo de camino, etc. El procesamiento de esta información requiere en un buen respaldo de hardware para soportar costos en tiempo y memoria mayores. Esto es, esencialmente la desventaja de utilizar el método de costo uniforme anteriormente mencionado.

### objetivo
El objetivo de este trabajo fué la búsqueda de estrategias alternativas que permitan encontrar el camino más corto a partir de dos puntos en un mapa de ciudad, que brinde como resultado entre las mejores soluciones sin requerir muchos recursos físicos.

### metodología
Se propuso aquí el uso de métodos de Inteligencia Colectiva, desde un enfoque de inteligencia Computacional, inspirados en el comportamiento biológico de las hormigas (que poseen un costo espacial acotado -cantidad de hormigas-).

### idea de solución
A modo de prototipado, se ha decidido encontrar una solución que permita a una persona conocer cual es un buen camino a seguir, que le permita ahorrar tiempo (~distancia) y dinero, considerando dos medios de traslado: a pie y mediante colectivos públicos urbanos.
Además, nos hemos propuesto el objetivo de comparar las distintas variaciones del algoritmo de colonia de hormigas y así poder seleccionar la alternativa mas adecuada.

## Técnicas utilizadas
* Inteligencia Artificial
  * Inteligencia Computacional
    * Metodo de busqueda de caminos optimos
    * Inteligencia Colectiva Metaheuristico
      * Algoritmos de Colonia de hormigas
      
## Implementación del algoritmo y resultados técnicos
Los detalles técnicos acerca de la implementación y los resultados obtenidos quedan, a continuación, en el enlace a mi página web personal de proyectos:
- [proyecto: hormigas urbanas](https://guobiloo.github.io/Hormigas-urbanas/)

## lenguajes y librerías consideradas
* python 2.7 (repositorio privado)
* matlab / octave 
* OpenStreetMaps (uso de mapas)

## Dependencias
El proyecto pudo realizarse gracias a la librería openstreetmap que permitió rápidamente copiar un mapa de la página web de OpenStreetMap y plotearlo en matlab, considerando las conectividades entre nodos (como las esquinas).
Por favor, visite la librería en el siguiente link para mas información:
https://github.com/johnyf/openstreetmap

## Ejecución
Para correr el proyecto, ejecute el script TPF.m

Dentro del script hay una sección llamada "RUTA MINIMA CON SISTEMA DE COLONIA DE HORMIGAS", el cual tiene los distintos métodos de hormigas (AS,sACO,MMAX,BWAS). Puede ir probando cada uno de los métodos solo considerando uno a la vez. Esto es así porque no se ha programado que todos los métodos se hagan de forma separada en distintas gráficas.

## Problemas
El algoritmo de sistema de hormigas MAX-MIN (MMAS) no funciona bien y puede tardar en encontrar una solución como estancarse.

## Autores
* Joaquin Gonzalez Budiño: <joa_gzb@hotmail.com> | <joa.gzb@gmail.com>
* Nicolas Giuliano: <nsgiuliano@gmail.com>
 
## Redes Sociales 
* [linkedin joaquin](https://www.linkedin.com/in/joaquin-gonzalez-budino/)
* [sitio web personal de proyectos](https://guobiloo.github.io/Hormigas-urbanas/)

## licencia
 Copyright (C) 2020  Gonzalez Budiño Joaquin

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

