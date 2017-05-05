#!/bin/bash

# build the torch shared libraries
export CMAKE_LIBRARY_PATH=$PREFIX/lib:$PREFIX/include:$CMAKE_LIBRARY_PATH
export CMAKE_PREFIX_PATH=$PREFIX
# compile for Kepler, Kepler+Tesla, Maxwell
# 3.0, 3.5, 5.0, 5.2+PTX
export TORCH_CUDA_ARCH_LIST="3.0;3.5;5.0;5.2+PTX"
export TORCH_NVCC_FLAGS="-Xfatbin -compress-all"
export PYTORCH_BINARY_BUILD=1
export TH_BINARY_BUILD=1
cd torch/lib
./build_all.sh --with-cuda

# copy these libraries and include files
mkdir -p ${PREFIX}/lib
cp *.so* ${PREFIX}/lib

mkdir -p ${PREFIX}/include
cp *.h ${PREFIX}/include
cp -r include/* ${PREFIX}/include

# copy the torch_shm_manager binary
mkdir -p ${PREFIX}/bin
cp torch_shm_manager ${PREFIX}/bin/
