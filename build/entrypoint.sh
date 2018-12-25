#!/bin/bash
echo "Update Unturned Server..."
/srv/steamcmd/steamcmd.sh \
    +@sSteamCmdForcePlatformBitness 32  \
    +login ${ID} ${PASS} \
    +force_install_dir ${UNT_DIR} \
    +app_update 304930 \
    validate \
    +exit

if [ -e ${UNT_DIR}/RocketLauncher.exe ]; then
    echo "RocketLauncher.exe : Found."
    ./start.sh ${INSTANCE}
else
    echo "RocketLauncher.exe : Not Found."
    echo "RocketLauncher.exe : Downloading..."
    curl  -O https://ci.rocketmod.net/job/Rocket.Unturned/lastSuccessfulBuild/artifact/Rocket.Unturned/bin/Release/Rocket.zip 
    unzip -o Rocket.zip -d ${UNT_DIR}
    rm -f Rocket.zip
    chmod +x ${UNT_DIR}/Scripts/Linux/start.sh
    mv ${UNT_DIR}/Scripts/Linux/start.sh ${UNT_DIR}/
    mv ${UNT_DIR}/Scripts/Linux/*.exe ${UNT_DIR}/
    ./start.sh ${INSTANCE}
fi