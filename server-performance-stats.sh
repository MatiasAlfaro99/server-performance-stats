#!/bin/bash

get_cpu_usage() {
  LC_ALL=C top -bn1 | grep "Cpu(s)" | awk '{
        us=$2
        sy=$4
        id=$8
        used=100-id
        printf "Usuario: %s%% | Sistema: %s%% | Libre (Inactivo): %s%% | %.1f%% Usado\n", us, sy, id, used
    }'
}

get_memory_usage() {
    free -m | awk 'NR==2{printf "Total: %sMB | Usado: %sMB | Libre: %sMB | Cache: %sMB | Disp: %sMB | %.2f%% Usado\n", $2, $3, $4, $6, $7, $3*100/$2 }'
}

get_disk_usage() {
    df -h / | awk 'NR==2 {printf "Total: %s | Usado: %s | Libre: %s | %s Usado\n", $2, $3, $4, $5}'
}

get_top_cpu_processes() {
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}
get_top_mem_processes() {
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
}
get_os_info() {
    grep "^PRETTY_NAME=" /etc/os-release | cut -d'=' -f2 | tr -d '"'
}

get_uptime_info() {
    uptime -p
}

get_load_avg() {
    cat /proc/loadavg | awk '{print $1, $2, $3}'
}

get_logged_in_users() {
    who | wc -l
}

get_failed_logins() {
    if [ -r /var/log/secure ]; then
        grep "Failed password" /var/log/secure | wc -l
    else
        echo "Permiso denegado"
    fi
}

echo "--- USO DE CPU ---"
echo "USO DE CPU: $(get_cpu_usage)%"
echo ""
echo "--- USO DE MEMORIA ---"
get_memory_usage
echo ""
echo "--- USO DE DISCO ---"
get_disk_usage
echo ""
echo "--- TOP 5 PROCESOS (CPU) ---"
get_top_cpu_processes

echo ""
echo "--- TOP 5 PROCESOS (MEMORIA) ---"
get_top_mem_processes
echo ""
echo "SO: $(get_os_info)"
echo ""
echo "Uptime: $(get_uptime_info)"
echo ""
echo "Load Average: $(get_load_avg)"
echo ""
echo "Usuarios con sesión iniciada: $(get_logged_in_users)"
echo ""
echo "Intentos fallidos SSH: $(get_failed_logins)"
