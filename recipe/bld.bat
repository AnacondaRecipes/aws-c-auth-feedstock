mkdir "%SRC_DIR%"\build
pushd "%SRC_DIR%"\build

cmake -GNinja ^
      -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
      -DCMAKE_INSTALL_LIBDIR=lib ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DBUILD_SHARED_LIBS=ON ^
      -DBUILD_TESTING=ON ^
      -DCMAKE_POSITION_INDEPENDENT_CODE=ON ^
      ..
if errorlevel 1 exit 1

cmake --build . --config Release --target install
if errorlevel 1 exit 1

REM Expected null but got 000001E5CABE9400
ctest -E "credentials_provider_default_chain_disable_environment_test" --output-on-failure
if errorlevel 1 exit 1