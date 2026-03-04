# Server Performance Stats (`server-stats.sh`)

## Proyecto original

### Requirements

You are required to write a script `server-stats.sh` that can analyse basic server performance stats. You should be able to run the script on any Linux server and it should give you the following stats:

- Total CPU usage  
- Total memory usage (Free vs Used including percentage)  
- Total disk usage (Free vs Used including percentage)  
- Top 5 processes by CPU usage  
- Top 5 processes by memory usage  

Stretch goal: Feel free to optionally add more stats such as:
- OS version  
- Uptime  
- Load average  
- Logged in users  
- Failed login attempts  

---

## Descripción del Problema

El problema exige la construcción de un script capaz de extraer, calcular y formatear métricas de rendimiento del sistema operativo.

Este script debe reducir al mínimo la instalación de dependencias externas, utilizando únicamente herramientas estándar disponibles en la mayoría de distribuciones Linux.

---

## Instalación y Uso

Otorga permisos de ejecución al archivo:

```bash
chmod +x server-performance-stats.sh
```

Ejecuta el script:

```bash
./server-performance-stats.sh
```

---

## Desglose Técnico de Comandos Utilizados

| Instrucción Completa | Desglose Técnico de Parámetros | Propósito en el Script |
|----------------------|--------------------------------|------------------------|
| `top -bn1` | `-b` (Batch mode): Ejecuta en modo por lotes sin interfaz interactiva. <br> `-n 1` (Number of iterations): Ejecuta solo un ciclo de lectura. | Capturar una “fotografía” estática e instantánea del estado de la CPU para que pueda procesarse como texto plano. |
| `free -m` | `-m` (Megabytes): Muestra la memoria en MB en lugar de bytes. | Estandarizar la unidad de medida para calcular el porcentaje de uso de RAM de forma legible. |
| `df -h /` | `-h` (Human-readable): Muestra tamaños en MB/GB. <br> `/`: Apunta al punto de montaje raíz. | Extraer el tamaño y espacio disponible de la partición principal del sistema. |
| `ps -eo pid,comm,%cpu` | `-e` (Every): Selecciona todos los procesos. <br> `-o` (Output format): Define columnas específicas (`pid`, `comm`, `%cpu`). | Filtrar la salida de `ps` para obtener solo los datos necesarios para el Top 5. |
| `ps --sort=-%cpu` | `--sort`: Ordena la salida. <br> `-` (menos): Orden descendente. <br> `%cpu`: Columna utilizada para ordenar. | Colocar el proceso que más consume CPU en la parte superior. |
| `head -n 6` | `-n 6`: Limita la salida a 6 líneas. | Mostrar la cabecera más los 5 procesos principales. |
| `uptime -p` | `-p` (Pretty): Formato legible del tiempo activo del sistema. | Obtener el uptime sin conversiones manuales desde `/proc/uptime`. |
| `wc -l` | `-l` (Lines): Cuenta saltos de línea. | Convertir listas (usuarios conectados o intentos fallidos) en valores numéricos absolutos. |
