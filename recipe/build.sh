#!/bin/bash
export DISABLE_AUTOBREW=1

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" == "1" ]]; then
  # Avoid build-time R invocations when cross-compiling.
  sed -i.bak \
    -e 's|^PKG_CPPFLAGS=\(.*\)-DIS_UTF8_LOCALE=.*$|PKG_CPPFLAGS=\1-DIS_UTF8_LOCALE=1|' \
    -e 's|^PKG_CXXFLAGS = .*RcppParallel::CxxFlags().*$|PKG_CXXFLAGS = -DTBB_INTERFACE_NEW @TBB_FLAG@|' \
    -e 's|^PKG_LIBS = .*RcppParallel::RcppParallelLibs().*$|PKG_LIBS = -L. @COMPILER_SPECIFIC_LIBS@ @ZSTD_LIBS@ -ltbb -ltbbmalloc|' \
    src/Makevars.in
  rm -f src/Makevars.in.bak
fi

${R} CMD INSTALL --build . ${R_ARGS}
