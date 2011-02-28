@echo off
setlocal EnableDelayedExpansion

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
	echo Install Path
	echo -----------
	echo Specify directory in which to create new CakePHP project - LEAVE A TRAILING /
	echo.
	echo Library Dir
	echo -----------
	echo Specify directory in which to look for CakePHP lib files - LEAVE A TRAILING / (defaults to C:\wamp\www\cakephp\)
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

	set /a strlen=(%random% %% 1) + 20
	for /l %%a in (1 1 %strlen%) do (
    		set /a char=!random! %% 62
    		for %%b in (!char!) do set salt=!salt!!salt_chars:~%%b,1!
	)

	set /a strlen=(%random% %% 1) + 20
	for /l %%a in (1 1 %strlen%) do (
    		set /a char=!random! %% 10
    		for %%b in (!char!) do set cipher=!cipher!!cipher_chars:~%%b,1!
	)

	set salt_txtdefault=Configure::write('Security.salt', 'DYhG93b0qyJfIxfs2guVoUubWwvniR2G0FgaC9mi');
	set cipher_txtdefault=Configure::write('Security.cipherSeed', '76859309657453542496749683645');
	set salt_txtreplace=Configure::write('Security.salt', '%salt%');
	set cipher_txtreplace=Configure::write('Security.cipherSeed', '%cipher%');
	set configfile=
	
	if exist %2%app\config\core.php.tmp goto del_tmp_core

:final
	for /f "tokens=*" %%a in (%2%app\config\core.php) do (
		set write=%%a
		if %%a==!salt_txtdefault! set write=!salt_txtreplace!
		if %%a==!cipher_txtdefault! set write=!cipher_txtreplace!
		echo !write!>>%2%app\config\core.php.tmp
	)
	move %2app\config\core.php.tmp %2app\config\core.php
	
	goto created

:del_tmp_core
	del %2%app\config\core.php.tmp
	goto final

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