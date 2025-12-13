#!/bin/bash
source "scripts/tests/base_test.sh"
SCRIPT="scripts/02_flow_control/01_if_else.sh"

test_case "numero mayor que 10" \
 "echo -e \"11\" | $SCRIPT" \
  "Su numero es mayor que 10" \
  0
test_case "numero no mayor que 10" \
 "echo -e \"5\" | $SCRIPT" \
  "Su numero no es mayor que 10" \
  0

summary || exit 1

