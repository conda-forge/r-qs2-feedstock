#!/bin/bash
export DISABLE_AUTOBREW=1

sed "s|\${R_HOME}|${CONDA_PREFIX}|g" src/Makevars.in > src/Makevars.in.tmp
mv src/Makevars.in.tmp src/Makevars.in

${R} CMD INSTALL --build . ${R_ARGS}
