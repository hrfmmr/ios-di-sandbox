#!/bin/sh
TARGET=$1
mint run mockolo mockolo \
  --mock-all \
  -i "$TARGET" \
  -s Core \
  -s Features/"$TARGET"/"$TARGET" \
  -s Features/"$TARGET"/"$TARGET"Tests \
  -d Features/"$TARGET"/"$TARGET"Tests/GeneratedMocks.swift; \
