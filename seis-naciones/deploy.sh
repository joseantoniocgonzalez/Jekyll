#!/bin/bash

# Ruta del proyecto Jekyll
PROJECT_PATH="/home/jose/github/Jekyll/seis-naciones"
# Ruta donde se almacenará el sitio generado
GENERATED_PATH="/home/jose/Jekyll-Sitio-Generado"
DEPLOY_PATH="jekyllconsite"
# Dominio en Surge
SURGE_DOMAIN="rightful-guitar.surge.sh"

echo "Generando el sitio con Jekyll..."
cd $PROJECT_PATH

# Generar el sitio
bundle exec jekyll build

echo "Copiando archivos generados al repositorio de sitio..."
# Limpiar la carpeta destino antes de copiar
rm -rf $GENERATED_PATH/$DEPLOY_PATH/*
# Copiar los archivos generados al destino
cp -r _site/* $GENERATED_PATH/$DEPLOY_PATH/

# Navegar al repositorio del sitio generado
cd $GENERATED_PATH/$DEPLOY_PATH

echo "Añadiendo y haciendo commit de los archivos en el repositorio de sitio..."
# Añadir archivos, hacer commit y push
git add .
git commit -m "Actualizar sitio generado"
git push origin main

echo "Desplegando en Surge..."
# Desplegar con Surge
surge --domain $SURGE_DOMAIN

echo "Despliegue completado. Visita: https://$SURGE_DOMAIN"
