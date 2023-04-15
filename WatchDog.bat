@echo off
:://////////////////////////////////////////////////////////////////////////
:://                     WatchDog Configuration file                     ///
:://////////////////////////////////////////////////////////////////////////
:://                Name of the server to identify your bat              ///
:://////////////////////////////////////////////////////////////////////////

set name=My PlutoT6 MP Server 1

:://////////////////////////////////////////////////////////////////////////
:://      The regex search for the window name of the sever. (optional)   //
:://                                                                      //
:://     This will help identify which window needs closing in case the   //
:://     server errors out or freezes according to filename on g_log      //
:://                                                                      //
:://     No color codes! This is base off your server window title!       //
:://////////////////////////////////////////////////////////////////////////

set server_title_regex=Plutonium T6 Dedicated Server

:://////////////////////////////////////////////////////////////////////////
:://    Rate to check if server crash or freeze by reading game_mp.log    //
::// If gts timelimit is longer then 10 mins. You might want to increase  //
:://////////////////////////////////////////////////////////////////////////
:://   10800 - 3 hours                                                    //
:://   7200 - 2 hours                                                     //
:://   3600 - 1 hour                                                      //
:://   1800 - 30 mins                                                     //
:://   1200 - 20 mins   (recommended)                                     //
:://   900 - 15 mins                                                      //
:://   720 - 12 mins                                                      //
:://   660 - 11 mins    (Don't recommend!)                                //
:://////////////////////////////////////////////////////////////////////////

set check_rate=1200

:://////////////////////////////////////////////////////////////////////////
:://                  Server log location and filename                    //
:://          Only change if you hosting more then 1 server               //
:://      Unless you change g_log on server.cfg then match with that.     //
:://////////////////////////////////////////////////////////////////////////

set log_path=%localappdata%\Plutonium\storage\t6\logs
set log_file=games_mp.log






:://////////////////////////////////////////////////////////////////////////
:://  DONE!! WARNING! Don't mess with anything below this line. SEROUSLY! //
:://             Only edit if you know what you doing!!!                  //
:://////////////////////////////////////////////////////////////////////////

::ADVANCED USERS
set gamepath=%cd%
set server_exe=plutonium-bootstrapper-win32.exe

::The Magic happens below..
::Code inspired by Guy from botware.
::Reference https://github.com/ineedbots/iw4x_bot_warfare/blob/master/z_server_watchdog.bat

title %name% - Server watchdog
echo (%date%)  -  (%time%) Now watching %log_path%\%log_file% modified date.
::https://superuser.com/questions/699769/batch-file-last-modification-time-with-seconds
dir "%log_path%"\"%log_file%" > nul
for /f "delims=" %%i in ('"forfiles /p "%log_path%" /m "%log_file%" /c "cmd /c echo @ftime" "') do set modif_time_temp=%%i

:Server
	set modif_time=%modif_time_temp%

	timeout /t %check_rate% /nobreak > nul
    ::echo (%date%)  -  (%time%) Checking if %log_file% date has been modified since %check_rate% seconds is up...
	
	dir "%log_path%"\"%log_file%" > nul
	for /f "delims=" %%i in ('"forfiles /p "%log_path%" /m "%log_file%" /c "cmd /c echo @ftime" "') do set modif_time_temp=%%i

	if "%modif_time_temp%" == "%modif_time%" (
		echo "(%date%)  -  (%time%) WARNING: %name% server hung, killing server..."
		::https://stackoverflow.com/questions/26552368/windows-batch-file-taskkill-if-window-title-contains-text
		for /f "tokens=2 delims=," %%a in ('
			tasklist /fi "imagename eq %server_exe%" /v /fo:csv /nh
			^| findstr /r /c:"%server_title_regex%"
		') do taskkill /pid %%a /f
	    timeout /T 8 /nobreak > nul	
	    echo "(%date%)  -  (%time%) Now watching %log_path%\%log_file% modified date again."	
	)
goto Server