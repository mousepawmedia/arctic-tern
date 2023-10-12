@echo off

setlocal
set LIB_PROJECT=Arctic Tern
set EXE_PROJECT=Arctic Tern Tester
set LIB_NAME=arctic-tern
set EXE_NAME=%LIB_NAME%-tester
set EXE_NICKNAME=tester
set /A HEADER_ONLY=1
set LIB_SRC=%LIB_NAME%-source
set EXE_SRC=%EXE_NAME%
set READY_DIR=%LIB_NAME%

call build_system\outer.bat %*
endlocal
