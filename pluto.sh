#!/bin/bash


updatePluto() {
    WINEDEBUG=-all wine cmd.exe /C \!updatePluto.bat
}

runMP() {
    WINEDEBUG=-all wine cmd.exe /C \!start_mp_server.bat
}

runZM() {
    WINEDEBUG=-all wine cmd.exe /C \!start_zm_server.bat
}

case "$1" in
up) updatePluto;;
mp) runMP;;
zm) runZM;;
*)  me=`basename "$0"`
    echo "Usage: $me (up|mp|zm)"
    ;;
esac