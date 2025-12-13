#!/bin/bash
CSV_FILE="usuarios.csv"
LOG_FILE="/var/log/gestion_usuarios.log"
ELIMINADOS="/home/.eliminados"
mkdir -p "$ELIMINADOS"
log() {
echo "$(date '+%Y-%m-%d %H:%M:%S') - $1 - $2" >> "$LOG_FILE"
}
while IFS=',' read -r usuario grupo operacion; do
# Saltar líneas vacías o comentarios
[[ -z "$usuario" || "$usuario" =~ ^# ]] && continue
# Si el grupo no existe, crearlo
if ! getent group "$grupo" >/dev/null; then
groupadd "$grupo"
log "INFO" "Creado grupo $grupo"
fi
case "$operacion" in
add)
if id "$usuario" &>/dev/null; then
log "ERROR" "Usuario $usuario ya existe. Línea
ignorada."
continue
fi
home_dir="/home/$usuario"
mkdir -p "$home_dir"
useradd -m -d "$home_dir" -g "$grupo" "$usuario"
echo "${usuario}:${usuario}" | chpasswd
log "INFO" "Contraseña asignada al usuario $usuario"
log "ADD" "Usuario $usuario añadido al grupo $grupo"
;;
rm)
if ! id "$usuario" &>/dev/null; then
log "ERROR" "Usuario $usuario no existe. Línea
ignorada."
continue
fi

if passwd -S "$usuario" | grep -q "L"; then
log "ERROR" "Usuario $usuario ya estaba bloqueado.
Línea ignorada."
continue
fi

usermod -L "$usuario"
usuario_home=$(eval echo "~$usuario")
if [ -d "$usuario_home" ]; then
mv "$usuario_home" "$ELIMINADOS/"
fi
log "RM" "Usuario $usuario bloqueado y movido a
.eliminados"
;;
*)
log "ERROR" "Operación desconocida: $operacion"
;;
esac
done < "$CSV_FILE"
