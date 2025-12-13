#!/bin/bash
for ip in $(cat /home/usuario/remotos.txt)
do
echo "root" | scp /home/usuario/usuarios.csv usuario@$ip:/home/usuario
done
