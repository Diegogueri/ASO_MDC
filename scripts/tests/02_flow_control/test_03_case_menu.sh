#!/bin/bash
source "scripts/tests/base_test.sh"
SCRIPT="scripts/02_flow_control/03_case_menu.sh"

test_case "opcion 1" \
  "echo -e \"1\" | $SCRIPT" \
  "*La fecha actual es*" \
  0

test_case "opcion 2" \
  "echo -e \"2\" | $SCRIPT" \
  "*El usuario acutual es*" \
  0

test_case "opcion 3" \
  "echo -e \"3\" | $SCRIPT" \
  "*Saliendo" \
  1

test_case "otra opcion" \
  "echo -e \"5\" | $SCRIPT" \
  "*No coincide con ninguna de las opciones" \
  0


summary || exit 1
