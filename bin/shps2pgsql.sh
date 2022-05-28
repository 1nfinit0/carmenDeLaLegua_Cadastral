#
#   Autor:  Luis Huatay
#   Fecha:  Mayo 2022
#   Descripcion: Script para enviar shapefiles a postgresql
#

# Teniendo en cuenta la ubicación de los archivos .shp entonces:

shp2pgsql -s 32718:4326 -d -I -g geom ../shapefiles/shp_clegua/limite_cl.shp clegua.limite | psql -d catastro -U dbatobi -W
shp2pgsql -s 32718:4326 -d -I -g geom ../shapefiles/shp_clegua/sectores.shp clegua.sector | psql -d catastro -U dbatobi -W
shp2pgsql -s 32718:4326 -d -I -g geom ../shapefiles/shp_clegua/manzanas_cl.shp clegua.manzana | psql -d catastro -U dbatobi -W
shp2pgsql -s 32718:4326 -d -I -g geom ../shapefiles/shp_clegua/lotizacion_CL.shp clegua.lote | psql -d catastro -U dbatobi -W
