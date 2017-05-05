#!/bin/bash

# Limit compute_arch to those supports by CUDA 7.5
export NVCC_GENCODE="-gencode=arch=compute_35,code=sm_35 \
    -gencode=arch=compute_50,code=sm_50 \
    -gencode=arch=compute_52,code=sm_52"
make -j${CPU_COUNT}
make install
