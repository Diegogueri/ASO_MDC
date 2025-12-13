#!/bin/bash
source "scripts/tests/base_test.sh"
SCRIPT="../scripts/02_flow_control/05_for_files.sh"

mkdir prueba
cd prueba
mkdir test1

test_case "directorio" \
  "$SCRIPT" \
  "*test1 es un directorio*" \
  0
rm -r test1
touch test.txt

test_case "fichero" \
  "$SCRIPT" \
  "*Nombre del archivo: test.txt*" \
  0

rm test.txt
mkfifo test

test_case "otro" \
  "$SCRIPT" \
  "*Elemento desconocido*" \
  0

cd ..
rm -r prueba

summary || exit 1
