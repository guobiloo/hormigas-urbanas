clear all
clc
close all

%ESTE SCRIPT TIENE LA FINALIDAD DE CARGAR EL ESPACIO DE TRABAJO, ES DECIR, ALZAR EL MAPA Y TODA SU
%INFORMACION CONTENIDA EN DISTINTAS VARIABLES. EL CONJUNTO DE ESTAS VARIABLES FORMAN EL ESPACIO DE
%TRABAJO Y SE GUARDAN EN UN ARCHIVO .mat PARA LUEGO SER LEVANTADA SIN TENER QUE RECALCULAR TODO.

%% filename and dependencies
addpath(genpath('./openstreetmap-0.2.2')); %agregar las dependencias necesarias para correr esta libreria
openstreetmap_filename = 'mapa_doble.osm';

%% convert XML -> MATLAB struct
[parsed_osm, osm_xml] = parse_openstreetmap(openstreetmap_filename);

%% find connectivity
[connectivity_matrix, intersection_node_indices] = extract_connectivity(parsed_osm); %crea matriz sparse
intersection_nodes = get_unique_node_xy(parsed_osm, intersection_node_indices);

%% MATRIZ DE ADYACENCIA
% M=matriz_adyacencia_km(intersection_nodes.xys,intersection_node_indices,connectivity_matrix);

%considerar que no importa el sentido de las calles
M = or(connectivity_matrix, connectivity_matrix.'); % make symmetric
[tam1,tam2]=size(M);
M2=sparse(tam1,tam2);

%% correcciones de aristas erroneas
M(273,206)=0;
M(206,273)=0;