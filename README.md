# Server Performance Stats (`server-stats.sh`)

## Proyecto original

**Requirements:**

You are required to write a script `server-stats.sh` that can analyse basic server performance stats. You should be able to run the script on any Linux server and it should give you the following stats:

* Total CPU usage
* Total memory usage (Free vs Used including percentage)
* Total disk usage (Free vs Used including percentage)
* Top 5 processes by CPU usage
* Top 5 processes by memory usage

*Stretch goal: Feel free to optionally add more stats such as os version, uptime, load average, logged in users, failed login attempts etc.*

El problema exige la construcción de un script capaz de extraer, calcular y formatear métricas de rendimiento del sistema operativo. Este script debe reducir al mínimo la instalación de una dependencia externa.

## Instalación y Uso

Otorga permisos de ejecución al archivo:
```bash
chmod +x server-stats.sh

Ejecuta el script de manera estándar:
./server-stats.sh
Instrucción Completa,Desglose Técnico de Parámetros,Propósito en el Script
top -bn1,"-b (Batch mode): Ejecuta en modo por lotes, enviando la salida directamente a la consola en lugar de abrir la interfaz interactiva.-n 1 (Number of iterations): Obliga al comando a detenerse después de leer exactamente un ciclo del procesador.","Capturar una ""fotografía"" estática e instantánea del estado de la CPU para que awk pueda procesarla como texto plano sin que la pantalla se actualice infinitamente."
free -m,-m (Megabytes): Fuerza al kernel a calcular y mostrar la asignación de bloques de memoria en megabytes en lugar de bytes (por defecto).,Estandarizar la unidad de medida para realizar el cálculo matemático del porcentaje de uso de RAM de forma legible.
df -h /,"-h (Human-readable): Convierte los bloques de 1K a potencias de 1024 (Megabytes, Gigabytes)./ (Target): Apunta estrictamente al punto de montaje raíz.","Extraer el tamaño exacto y el espacio disponible de la partición principal donde reside el sistema operativo, ignorando unidades virtuales."
"ps -eo pid,comm,%cpu","-e (Every): Selecciona absolutamente todos los procesos en ejecución.-o (Output format): Define las columnas exactas a mostrar. Aquí exigimos el Process ID (pid), el nombre del binario (comm) y el uso de procesador (%cpu).","Filtrar el ""ruido"" del comando ps para que solo entregue la tabla limpia con los tres datos que necesitamos para el Top 5."
--sort=-%cpu(Argumento de ps),--sort: Aplica un algoritmo de ordenamiento a la salida.- (Menos): Indica orden descendente (de mayor a menor).%cpu: La columna por la cual ordenar.,"Colocar el proceso que más satura la CPU en la parte superior de la lista, seguido por el resto en orden decreciente."
head -n 6,-n 6 (Number of lines): Corta el flujo de texto exactamente en la sexta línea.,Mostrar la cabecera de las columnas de ps (línea 1) y aislar estrictamente los 5 procesos principales (líneas 2 a 6).
uptime -p,"-p (Pretty): Formatea el tiempo bruto del kernel en una cadena de texto amigable (ej. ""up 2 hours, 15 minutes"").",Evitar conversiones matemáticas manuales desde el archivo virtual /proc/uptime.
wc -l,-l (Lines): Cuenta estrictamente la cantidad de saltos de línea (\n) que recibe en la entrada estándar.,Transformar la lista de usuarios conectados (salida de who) o la lista de intentos fallidos (salida de grep) en un número entero absoluto para nuestro reporte.
