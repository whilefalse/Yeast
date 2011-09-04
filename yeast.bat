@echo off & setlocal EnableDelayedExpansion

rem ---------------------------------------------------
rem ---------------------------------------------------
rem DEVELOPED BY ARRON BAILISS <arron@arronbailiss.com>
rem http://www.arronbailiss.com
rem ---------------------------------------------------
rem ---------------------------------------------------

set cakelib=C:\wamp\www\cakephp\
set salt_chars=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
set cipher_chars=0123456789
set salt=
set cipher=

:start
	if [%1]==[] goto usage
	if [%2]==[] goto usage
	if not [%3]==[] set cakelib=%3
	if [%1]==[create] goto create
	goto usage

:usage
	echo Usage
	echo -----------
	echo yeast create [install_path] ^<library_path^>
	echo.
	echo install_path: 
	echo 	Specify directory in which to create new CakePHP project
	echo 	LEAVE A TRAILING \
	echo.
	echo library_path:
	echo 	Specify directory in which to look for CakePHP lib files
	echo 	LEAVE A TRAILING \ (defaults to C:\wamp\www\cakephp\)
	goto eof

:create
	
	if exist %2 goto error_installdir
	if not exist %cakelib% goto error_libdir

	mkdir %2
	xcopy /E /R %cakelib%*.* %2

	set dbdefault=%2%app\config\database.php.default
	set dbreplace=%2%app\config\database.php
	if exist %dbdefault% move %dbdefault% %dbreplace%

	echo.
	if not errorlevel 0 goto error_copy

:created
	echo Created CakePHP project at %2%
	goto eof

:error_installdir
	echo It looks like there's already a directory there. I'm not going to overwrite it.
	goto eof

:error_libdir
	echo Couldn't find CakePHP library files at %cakelib%. Make sure it's installed, or pass the ^<library_path^> parameter to specify the path manually
	goto eof

:error_copy
	echo Couldn't create project at %2. Does the parent directory exist?
	goto eof

:eof
	echo.
	endlocal
	pause