#!/bin/sh

app_DI() {
  needle generate \
    app/DI/NeedleGenerated.swift \
    .needle/source_list_files.txt \
    --header-doc .needle/copyright_header.txt
}

features_DI() {
  FEATURES=$(find Features -type d -depth 1 | sed -e "s/^Features\/\(.*\)$/\1/")
  for target in $FEATURES; do
    needle generate \
      Features/"$target"/"$target"SandboxApp/DI/NeedleGenerated.swift \
      Features/"$target" \
      --header-doc .needle/copyright_header.txt
  done
}

set -euo pipefail

app_DI
features_DI
