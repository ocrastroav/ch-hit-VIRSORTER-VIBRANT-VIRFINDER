#!/bin/bash

# Verificar que se proporcionaron todas las rutas necesarias
if [ $# -ne 4 ]; then
  echo "Se requieren 4 argumentos:"
  echo "1. Ruta del directorio principal"
  echo "2. Ruta de VIBRANT"
  echo "3. Ruta de VirFinder"
  echo "4. Ruta de VirSorter"
  exit 1
fi

# Asignar los argumentos a variables
main_directory=$1
vibrant_directory=$2
virfinder_directory=$3
virsorter_directory=$4

# Obtener la lista de carpetas en el directorio principal
folders=$(find "$main_directory" -maxdepth 1 -type d ! -path "$main_directory")

# Iterar sobre cada carpeta
for folder in $folders; do
  # Extraer el número de la carpeta
  number=$(basename "$folder")

  # Ingresar a la carpeta
  cd "$folder"

  # Enlace simbólico a muestra-VIBRANT.fasta
  ln -s "$vibrant_directory/VIBRANT_${number}-contigs/VIBRANT_phages_${number}-contigs/${number}-contigs.phages_combined.fna" "${number}-VIBRANT.fasta"

  # Enlace simbólico a muestra-virfinder.fasta
  ln -s "$virfinder_directory/${number}-viral-virfinder.fa" "${number}-virfinder.fasta"

  # Enlace simbólico a muestra-virsorter.fasta
  ln -s "$virsorter_directory/virsorter-${number}/final-viral-combined.fa" "${number}-virsorter.fasta"

  # Concatenar los archivos *.fasta en un archivo llamado "number-phages.fasta"
  cat *.fasta > "${number}-phages.fasta"

  # Ejecutar cd-hit-est con los parámetros proporcionados
  cd-hit-est -i "${number}-phages.fasta" -o "${number}-representative.fasta" -c 0.95 -d 0 -M 0 -T 0

  # Concatenar los archivos específicos y guardar los resultados en nuevos archivos
  cat "${number}-VIBRANT.fasta" "${number}-virfinder.fasta" > "${number}-VIBRANT-virfinder.fasta"
  cat "${number}-VIBRANT.fasta" "${number}-virsorter.fasta" > "${number}-VIBRANT-virsorter.fasta"
  cat "${number}-virfinder.fasta" "${number}-virsorter.fasta" > "${number}-virfinder-virsorter.fasta"

  # Ejecutar cd-hit-est-2d con los parámetros proporcionados para los archivos generados anteriormente
  cd-hit-est-2d -i "${number}-virfinder-virsorter.fasta" -i2 "${number}-VIBRANT.fasta" -o "${number}-only-VIBRANT" -c 0.95 -d 0 -M 0 -T 0
  cd-hit-est-2d -i "${number}-VIBRANT-virsorter.fasta" -i2 "${number}-virfinder.fasta" -o "${number}-only-virfinder" -c 0.95 -d 0 -M 0 -T 0
  cd-hit-est-2d -i "${number}-VIBRANT-virfinder.fasta" -i2 "${number}-virsorter.fasta" -o "${number}-only-virsorter" -c 0.95 -d 0 -M 0 -T 0

  # Contar las líneas que contienen ">" en los archivos generados y guardar el resultado en "number-only-sw"
  grep -c ">" "${number}-only-VIBRANT" "${number}-only-virsorter" "${number}-only-virfinder" > "${number}-only-sw"

  # Regresar al directorio anterior
  cd ..
done
