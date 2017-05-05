#!/bin/bash

# build the torch shared libraries
export CMAKE_LIBRARY_PATH=$PREFIX/lib:$PREFIX/include:$CMAKE_LIBRARY_PATH
export CMAKE_PREFIX_PATH=$PREFIX
export NO_CUDA=1
export PYTORCH_BINARY_BUILD=1
export TH_BINARY_BUILD=1
cd torch/lib
./build_all.sh

# copy these libraries and include files
mkdir -p ${PREFIX}/lib
cp *.so* ${PREFIX}/lib

mkdir -p ${PREFIX}/include
cp *.h ${PREFIX}/include
cp -r include/* ${PREFIX}/include

# copy the torch_shm_manager binary
mkdir -p ${PREFIX}/bin
cp torch_shm_manager ${PREFIX}/bin/
