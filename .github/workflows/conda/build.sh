#!/usr/bin/env bash

cmake -E make_directory build
cd build
cmake -G "Ninja" \
    -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
    -DCMAKE_PREFIX_PATH=$CONDA_PREFIX \
    -DLIB_SUFFIX="" \
    -DPYTHON_EXECUTABLE=$CONDA_PREFIX/bin/python \
    -DBoost_NO_BOOST_CMAKE=ON \
    -DGR_PYTHON_DIR=`python -c "import site; print(site.getsitepackages()[0])"` \
    ..
cmake --build . --config $BUILD_TYPE -- -j${NUM_JOBS:=2}
