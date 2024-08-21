@echo off
::Paste the server key from https://platform.plutonium.pw/serverkeys here
set key=placeServerKeyHere
::Name of the config file the server should use. (default: dedicated_zm.cfg)
set cfg=dedicated_zm.cfg
::Name of the server shown in the title of the cmd window. This will NOT bet shown ingame.
set name=ZM 1
::Port used by the server (default: 4976)
set port=4976
::Mod name (default "")
set mod=""
::Only change this when you don't want to keep the bat files in the game folder. MOST WON'T NEED TO EDIT THIS!
set gamepath=%cd%

title PlutoniumT6 - %name% - Server restarter
echo Visit plutonium.pw / Join the Discord (a6JM2Tv) for NEWS and Updates!
echo Server "%name%" will load %cfg% and listen on port %port% UDP!
echo To shut down the server close this window first!
echo (%date%)  -  (%time%) %name% server start.

cd /D %LOCALAPPDATA%\Plutonium
:server
start /wait /abovenormal bin\plutonium-bootstrapper-win32.exe t6zm "%gamepath%" -dedicated +set key %key% +set fs_game %mod% +set net_port %port% +exec %cfg%
echo (%date%)  -  (%time%) WARNING: %name% server closed or dropped... server restarts.
goto server