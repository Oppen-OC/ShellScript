#!/bin/bash

URL="https://datos.comunidad.madrid/dataset/3dacd589-ecca-485c-81b9-a61606b7199f/resource/ee75d31c-8042-4067-bbd7-739bb3eb8059/download"
fecha=$(date +%Y-%m-%d)
LOGDIR="$(pwd)/informes"
LOGFILE="${LOGDIR}/informe-${fecha}.log"
REGDIR="$(pwd)/registros"
ARCHIVO_DEST="${REGDIR}/aire_${fecha}.csv"

# Descargar archivo y guardar salida y errores en el log
wget -O "$ARCHIVO_DEST" "$URL" >> "$LOGFILE" 2>&1
if [ $? -ne 0 ]; then
    echo "Error: Falló la descarga del archivo." | tee -a "$LOGFILE"
    exit 1
fi

# Verificar que el archivo existe y no está vacío
if [ ! -s "$ARCHIVO_DEST" ]; then
    echo "Error: El archivo descargado no existe o está vacío." | tee -a "$LOGFILE"
    exit 2
fi

echo 0