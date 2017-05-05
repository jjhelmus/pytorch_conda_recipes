#!/bin/bash

# The common torch shared libraries and include files are packaged separately
# in libtorch. For the Python build these need to be placed into the correct
# location. They are removed from the install below.
cp ${PREFIX}/lib/libTH.so.1 ./torch/lib/libTH.so.1
cp ${PREFIX}/lib/libTHS.so.1 ./torch/lib/libTHS.so.1
cp ${PREFIX}/lib/libTHPP.so.1 ./torch/lib/libTHPP.so.1
cp ${PREFIX}/lib/libTHNN.so.1 ./torch/lib/libTHNN.so.1
cp ${PREFIX}/lib/libshm.so ./torch/lib/libshm.so

cp ${PREFIX}/lib/libTHC.so.1 ./torch/lib/
cp ${PREFIX}/lib/libTHCS.so.1 ./torch/lib/
cp ${PREFIX}/lib/libTHCUNN.so.1 ./torch/lib/

# These do not get removed as they are needed at run-time
cp ${PREFIX}/bin/torch_shm_manager ./torch/lib/torch_shm_manager
cp ${PREFIX}/include/THNN.h ./torch/lib/THNN.h
cp ${PREFIX}/include/THCUNN.h ./torch/lib/THCUNN.h

export CFLAGS=${CFLAGS}" -I${PREFIX}/include \
    -I${PREFIX}/include/TH \
    -I${PREFIX}/include/THPP \
    -I${PREFIX}/include/THNN \
    -I${PREFIX}/include/THCUNN \
    -I${PREFIX}/include/THS \
    -L${PREFIX}/lib"
export CMAKE_LIBRARY_PATH=$PREFIX/lib:$PREFIX/include:$CMAKE_LIBRARY_PATH
export CMAKE_PREFIX_PATH=$PREFIX
# compile for Kepler, Kepler+Tesla, Maxwell
# 3.0, 3.5, 5.0, 5.2+PTX
export TORCH_CUDA_ARCH_LIST="3.0;3.5;5.0;5.2+PTX"
export TORCH_NVCC_FLAGS="-Xfatbin -compress-all"
export PYTORCH_BINARY_BUILD=1
export TH_BINARY_BUILD=1
python setup.py install

# Remove the common torch shared libraries
rm ${SP_DIR}/torch/lib/libTH.so.1
rm ${SP_DIR}/torch/lib/libTHS.so.1
rm ${SP_DIR}/torch/lib/libTHPP.so.1
rm ${SP_DIR}/torch/lib/libTHNN.so.1
rm ${SP_DIR}/torch/lib/libshm.so

rm ${SP_DIR}/torch/lib/libTHC.so.1
rm ${SP_DIR}/torch/lib/libTHCS.so.1
rm ${SP_DIR}/torch/lib/libTHCUNN.so.1

# Remove the extraneous tools directory
rm -rf ${SP_DIR}/tools
