#!/bin/bash
export DISABLE_AUTOBREW=1

# Conditionally apply AVX2 only for x86_64, not for ARM64
if [[ "$(uname -m)" == "x86_64" ]]; then
  SIMD_FLAG="--with-simd=AVX2"
else
  SIMD_FLAG=""
fi

${R} CMD INSTALL --configure-args="${SIMD_FLAG}" --build . ${R_ARGS}