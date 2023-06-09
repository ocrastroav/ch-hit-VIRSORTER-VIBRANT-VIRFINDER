# ch-hit-VIRSORTER-VIBRANT-VIRFINDER


Este repositorio contiene un pequeño script en bash para ciertas tareas en diferentes carpetas. Es importante recalcar que el directorio donde se encuentran tus resultados de los programas de VIRSORTER-VIBRANT-VIRFINDER dependen de cada usuario. Debes modificar esto dependiendo de tu directorio.

## Descripción

El script principal, `automatizar.sh`, se encarga de ejecutar una serie de comandos dentro de cada carpeta numerada encontrada en el directorio raíz. Estos comandos realizan operaciones como enlaces simbólicos, concatenación de archivos fasta, y ejecución de programas como `cd-hit-est` y `cd-hit-est-2d`. Cada carpeta contiene archivos específicos que son procesados de acuerdo a las reglas establecidas en el script.


## Instrucciones de Uso

1. Asegúrate de tener los archivos de datos necesarios en las carpetas correspondientes.
2. Concede los permisos de ejecución mediante chmod +x cd-hit.sh
3. Ejecuta el script `cd-hit.sh` utilizando el comando `bash cd-hit.sh` en el directorio raíz que contiene las carpetas numeradas, dichas carpetas sería cada una de tus muestras. El script procesará cada carpeta por separado, realizando las operaciones necesarias.

**Nota:** Necesitas del software de CD-HIT. Lo podrás encontrar aquí: https://github.com/weizhongli/cdhit

## Autor

Este script fue creado por Óscar Vásquez Torres

## Contribuciones

Las contribuciones son bienvenidas. Si encuentras algún problema o tienes alguna sugerencia, no dudes en abrir un problema o enviar una solicitud de extracción.

