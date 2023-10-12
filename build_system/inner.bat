:: Inner Make.bat (MousePaw Media Build System)
:: Version: 3.3.0

:: LICENSE (BSD-3-Clause)
:: Copyright (c) 2018 MousePaw Media.
:: All rights reserved.
::
:: Redistribution and use in source and binary forms, with or without
:: modification, are permitted provided that the following conditions are met:
::
:: 1. Redistributions of source code must retain the above copyright notice,
:: this list of conditions and the following disclaimer.
::
:: 2. Redistributions in binary form must reproduce the above copyright notice,
:: this list of conditions and the following disclaimer in the documentation
:: and/or other materials provided with the distribution.
::
:: 3. Neither the name of the copyright holder nor the names of its contributors
:: may be used to endorse or promote products derived from this software without
:: specific prior written permission.
::
:: THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
:: AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
:: IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
:: ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
:: LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
:: CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
:: SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
:: INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
:: CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
:: ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
:: THE POSSIBILITY OF SUCH DAMAGE.
::
:: CONTRIBUTING
:: See https://www.mousepawmedia.com/developers for information
:: on how to contribute to our projects.

set CMAKE=cmake ..\.. -G"Ninja"
T_DEBUG=-DCMAKE_BUILD_TYPE=Debug
T_RELEASE=-DCMAKE_BUILD_TYPE=Release

P_DEF_CONF=default
P_CONF=-DCONFIG_FILENAME=
:: RESUME FROM HERE!

set MK_DIR=cmake -E make_directory
set CH_DIR=cmake -E chdir
set CP=cmake -E copy
set CP_DIR=cmake -E copy_directory
set RM=cmake -E rm -f
set RM_DIR=cmake -E rm -rf
set ECHO=cmake -E echo
set LN=cmake -E create_symlink

if [%1]==[] goto help
set target=%1
shift
set MORE_ARGS=%1 %2 %3 %4 %5 %6 %7 %8 %9
:: Because variables cannot be used in labels, we have to check those manually.
if %target%==%LIB_NAME% (
    call :lib
    goto exit
)
if %target%==%LIB_NAME%_debug (
    call :lib_debug
    goto exit
)
if %target%==%EXE_NICKNAME% (
    call :exe
    goto exit
)
if %target%==%EXE_NICKNAME%_debug (
    call :exe_debug
    goto exit
) else (
    call :%target%
    goto exit
)
goto exit

:help
%ECHO% "=== %LIB_PROJECT% ==="
exit /B 0

:clean
if NOT %HEADER_ONLY%==1 call %LIB_SRC%\make clean %MORE_ARGS%
call %EXE_SRC%\make clean %MORE_ARGS%
%RM% %EXE_NICKNAME%
%RM% %EXE_NICKNAME%_debug
%RM_DIR% %READY_DIR%
exit /B 0

:cleanall
call :clean
call docs\make clean %MORE_ARGS%
exit /B 0

:cleandebug
if NOT %HEADER_ONLY%==1 call %LIB_SRC%\make cleandebug %MORE_ARGS%
call %EXE_SRC%\make cleandebug %MORE_ARGS%
%RM% %EXE_NICKNAME%_debug
exit /B 0

:cleanrelease
if NOT %HEADER_ONLY%==1 call %LIB_SRC%\make cleanrelease %MORE_ARGS%
call %EXE_SRC%\make cleanrelease %MORE_ARGS%
%RM% %EXE_NICKNAME%
exit /B 0

:docs
call docs\make html %MORE_ARGS%
%ECHO% "-------------"
%ECHO% "<<<<<<< FINISHED >>>>>>>"
%ECHO% "View docs at 'docs\build\html\index.html"
%ECHO% "-------------"
exit /B 0

:docs
call docs\make latexpdf %MORE_ARGS%
%ECHO% "-------------"
%ECHO% "<<<<<<< FINISHED >>>>>>>"
%ECHO% "View docs at 'docs\build\html\%LIB_PROJECT%.pdf"
%ECHO% "-------------"
exit /B 0

:lib
if NOT %HEADER_ONLY%==1 call %LIB_SRC%\make release %MORE_ARGS%
%ECHO% "-------------"
%ECHO% "<<<<<<< FINISHED >>>>>>>"
if NOT %HEADER_ONLY%==1 (
    %ECHO% "%LIB_PROJECT% is in '%LIB_SRC%\lib\Release"
) else (
    %ECHO% "%LIB_PROJECT% is a header-only library in '%LIB_SRC%\include."
)
%ECHO% "-------------"
exit /B 0

:lib_debug
if NOT %HEADER_ONLY%==1 call %LIB_SRC%\make debug %MORE_ARGS%
%ECHO% "-------------"
%ECHO% "<<<<<<< FINISHED >>>>>>>"
if NOT %HEADER_ONLY%==1 (
    %ECHO% "%LIB_PROJECT% is in '%LIB_SRC%\lib\Debug"
) else (
    %ECHO% "%LIB_PROJECT% is a header-only library in '%LIB_SRC%\include."
)
%ECHO% "-------------"
exit /B 0

:ready
call :lib
%RM_DIR% %READY_DIR%
%ECHO% "Creating file structure..."
if NOT %HEADER_ONLY%==1 %MK_DIR% %READY_DIR%\lib
%CP_DIR% %LIB_SRC%\include\ %READY_DIR%\include\
if NOT %HEADER_ONLY%==1 %CP% %LIB_SRC%\lib\Release\* %READY_DIR%\lib\

%ECHO% "Copying README and LICENSE..."
%CP% README.md %READY_DIR%\README.md
%CP% LICENSE.md %READY_DIR%\LICENSE.md
%ECHO% "-------------"
%ECHO% "<<<<<<< FINISHED >>>>>>>"
%ECHO% "The library is in '%READY_DIR%'."
%ECHO% "-------------"
exit /B 0

:exe
call :lib
call %EXE_SRC%\make release %MORE_ARGS%
%RM% %EXE_NICKNAME%
%LN% %EXE_SRC%\bin\Release\%EXE_SRC% %EXE_NICKNAME%
%ECHO% "-------------"
%ECHO% "<<<<<<< FINISHED >>>>>>>"
%ECHO% "%EXE_PROJECT% is in '%EXE_SRC%\bin\Release'."
%ECHO% "The link '.\%EXE_NICKNAME%' has been created for convenience."
%ECHO% "-------------"
exit /B 0

:exe_debug
call :lib_debug
call %EXE_SRC%\make debug %MORE_ARGS%
%RM% %EXE_NICKNAME%_debug
%LN% %EXE_SRC%\bin\Debug\%EXE_SRC% %EXE_NICKNAME%_debug
%ECHO% "-------------"
%ECHO% "<<<<<<< FINISHED >>>>>>>"
%ECHO% "%EXE_PROJECT% is in '%EXE_SRC%\bin\Debug'."
%ECHO% "The link '.\%EXE_NICKNAME%_debug' has been created for convenience."
%ECHO% "-------------"
exit /B 0

:all
call :docs
call :exe
exit /B 0

:allfresh
call :cleanall
call :all
exit /B 0

:exit
exit /B 0
