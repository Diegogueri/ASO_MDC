#!/bin/bash
source "scripts/tests/base_test.sh"
SCRIPT="scripts/02_flow_control/06_while_counter.sh"

test_case "directorio" \
  "echo \"5\"|$SCRIPT" \
  "*1*5*Se han mostrado 5 numero" \
  0


summary || exit 1
