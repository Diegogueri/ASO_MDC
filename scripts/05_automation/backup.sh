#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Por favor escribe una ruta o varias rutas como parámetros"
else
    mkdir -p /tmp/backup

    for parametro in "$@"; do
        if [ -f "$parametro" ]; then
            zstd "$parametro" -o "/tmp/backup/$(basename "$parametro").zst"
        elif [ -d "$parametro" ]; then
            tar -cf "/tmp/backup/$(basename "$parametro").tar" -C "$(dirname "$parametro")" "$(basename "$parametro")"
            zstd "/tmp/backup/$(basename "$parametro").tar" -o "/tmp/backup/$(basename "$parametro").tar.zst"
            rm "/tmp/backup/$(basename "$parametro").tar"  # Eliminar archivo tar intermedio
        else
            echo "Error: $parametro no existe o no es un archivo/directorio válido."
        fi
    done

    nombre="$(cat /etc/hostname)_$(date +'%Y%m%d%H%M')"

    tar -cf /tmp/backup/backup_$nombre.tar -C /tmp/backup/ .

    scp "/tmp/backup/backup_$nombre.tar" asir@10.255.212.11:/home/asir/backups

    rm -r /tmp/backup
fi

condicion=$(ssh -t asir@10.255.212.11 "ls /home/asir/backups | wc -l")
condicion="${condicion%?}"
echo $condicion
while [ $condicion -gt 10 ]
do
	archivo_antiguo=$(ssh -t asir@10.255.212.11 "ls -tr /home/asir/backups/* | head -n 1")
	echo "$archivo_antiguo"
	archivo_antiguo="${archivo_antiguo%?}"
	ssh asir@10.255.212.11 "rm -r $archivo_antiguo"
	condicion=$(ssh -t asir@10.255.212.11 "ls /home/asir/backups | wc -l")
	condicion="${condicion%?}"

done
