#!/bin/bash
source "scripts/tests/base_test.sh"
SCRIPT="scripts/02_flow_control/02_elif.sh"

test_case "Aprobado" \
  "echo -e \"5\" | $SCRIPT" \
  "Aprobado" \
  0

test_case "Suspenso" \
  "echo -e \"2\" | $SCRIPT" \
  "Suspenso" \
  0

test_case "Bien" \
  "echo -e \"6\" | $SCRIPT" \
  "Bien" \
  0

test_case "notable" \
  "echo -e \"7\" | $SCRIPT" \
  "notable" \
  0

test_case "sobresaliente" \
  "echo -e \"9\" | $SCRIPT" \
  "Sobresaliente" \
  0

test_case "numero no valido" \
  "echo -e \"18\" | $SCRIPT" \
  "Su numero no estra dentro de los rangos de evaluación" \
  0

summary || exit 1
