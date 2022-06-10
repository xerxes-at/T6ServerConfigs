@echo off
::Name of the server's title
set name=Plutonium T6 Dedicated Server (r3208) - SERVER NAME GOES HERE AND ALSO EDIT (r3208) TO WHATEVER LASTEST
::Only change this when you don't want to keep the bat files in the game folder. 
::MOST WON'T NEED TO EDIT THIS!
set gamepath=%cd%
::Time Rate to check if server is hung via game log
::https://superuser.com/questions/699769/batch-file-last-modification-time-with-seconds
::1800 - 30 mins
::1200 - 20 mins
::900 - 15 mins
::720 - 12 mins
set check_rate=900
::Server log location
set log_path=%localappdata%\Plutonium\storage\t6\logs
set log_file=games_mp.log

title PltuoT6 - %name% - Server watchdog
echo (%date%)  -  (%time%) %name% server watchdog start.
for /f "delims=" %%i in ('"forfiles /p "%log_path%" /m "%log_file%" /c "cmd /c echo @ftime" "') do set modif_time_temp=%%i

:Server
	set modif_time=%modif_time_temp%

	timeout /t %check_rate% /nobreak > nul

	for /f "delims=" %%i in ('"forfiles /p "%log_path%" /m "%log_file%" /c "cmd /c echo @ftime" "') do set modif_time_temp=%%i

	if "%modif_time_temp%" == "%modif_time%" (
		echo "(%date%)  -  (%time%) WARNING: %name% server hung, killing server..."
		taskkill /FI "WINDOWTITLE eq %name%" /F
	)
goto Server