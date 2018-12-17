@echo off
::name of the config file the server should use.
set cfg=dedicated.cfg
::name of the server shown in the title of the cmd window
set name=TDM 1
::Port used by the server
set port=4976

title PlutoniumT6 - %name% - Server restarter
echo Visit plutonium.pw / Join the Discord (a6JM2Tv) for NEWS and Updates!
echo Server "%name%" will load %cfg% and listen on port %port% UDP!
echo To shut down the server close this window first!
echo (%date%)  -  (%time%) %name% server start.
:server
start /wait /abovenormal t6rmp.exe -dedicated +sv_config %cfg% +net_port %port%
echo (%date%)  -  (%time%) WARNING: %name% server closed or dropped... server restarts.
goto server