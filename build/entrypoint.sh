#!/bin/bash
if [ -e ${UNT_DIR}/Unturned.x86 ]; then
    echo "Unturned.x86 : Found."
else
    echo "Unturned.x86 : Not Found."
    /srv/steamcmd/steamcmd.sh +@sSteamCmdForcePlatformBitness 32  +login ${ID} ${PASS} +force_install_dir ${UNT_DIR} +app_update 304930 validate +exit
fi

if [ -e ${UNT_DIR}/RocketLauncher.exe ]; then
    echo "RocketLauncher.exe : Found."
    ./update.sh ${ID} ${PASS}
    ./start.sh ${INSTANCE}
else
    echo "RocketLauncher.exe : Not Found."
    echo "RocketLauncher.exe : Downloading..."
    curl  -O https://ci.rocketmod.net/job/Rocket.Unturned/lastSuccessfulBuild/artifact/Rocket.Unturned/bin/Release/Rocket.zip 
    unzip -o Rocket.zip -d ${UNT_DIR}
    rm -f Rocket.zip
    chmod +x ${UNT_DIR}/Scripts/Linux/*.sh
    mv ${UNT_DIR}/Scripts/Linux/*.sh ${UNT_DIR}/
    mv ${UNT_DIR}/Scripts/Linux/*.exe ${UNT_DIR}/
    ./update.sh ${ID} ${PASS}
    ./start.sh ${INSTANCE}
fi