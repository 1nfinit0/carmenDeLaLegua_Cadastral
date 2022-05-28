/*
    Fecha: Mayo 2022
    Autor: Luis Huatay
    Descripción: Creación de la base de datos
*/
DROP DATABASE IF EXISTS catastro;
CREATE DATABASE catastro;
\c catastro;
CREATE SCHEMA clegua;
CREATE EXTENSION postgis;
