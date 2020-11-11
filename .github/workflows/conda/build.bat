setlocal EnableDelayedExpansion
setlocal EnableExtensions
@echo on

if not defined NUM_JOBS set NUM_JOBS=2

cmake -E make_directory build
if errorlevel 1 exit 1

cd build
if errorlevel 1 exit 1

cmake -G "Ninja" ^
    -DCMAKE_BUILD_TYPE=%BUILD_TYPE% ^
    -DCMAKE_PREFIX_PATH="%CONDA_PREFIX%\Library\lib" ^
    -DPYTHON_EXECUTABLE="%CONDA_PREFIX%\python" ^
    -DBoost_NO_BOOST_CMAKE=ON ^
    -DGR_PYTHON_DIR="%CONDA_PREFIX%\Lib\site-packages" ^
    -DLIBCODEC2_INCLUDE_DIR="%CONDA_PREFIX%\Library\include\codec2" ^
    -DLIBCODEC2_LIBRARIES="%CONDA_PREFIX%\Library\lib\libcodec2.lib" ^
    -DMPIR_LIBRARY="%CONDA_PREFIX%\Library\lib\mpir.lib" ^
    -DMPIRXX_LIBRARY="%CONDA_PREFIX%\Library\lib\mpir.lib" ^
    -DQWT_LIBRARIES="%CONDA_PREFIX%\Library\lib\qwt.lib" ^
    ..
if errorlevel 1 exit 1

cmake --build . --config %BUILD_TYPE% -- -j%NUM_JOBS%
if errorlevel 1 exit 1
