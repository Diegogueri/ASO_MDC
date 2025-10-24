#!/bin/bash

#Pide que introduzca la ruta

read -p "Introduce ruta > " ruta


#Si la ruta no existe entonces:
if [[ ! -e $ruta ]];then

    echo "La ruta no existe"
#Si es un archivo entonces:
    elif [[ -f $ruta ]];then

    echo "Es un archivo regular"
#Si es un directorio entonces:
    elif [[ -d $ruta ]];then

    echo "Es un directorio"

fi 

#Si se introduce la absoluta, el script funcionara independientemente de donde se ejecuta el script, 
#sin embargo, al introducir la ruta relativa, la ubicacion en la que se ejecute el script si es importante.
