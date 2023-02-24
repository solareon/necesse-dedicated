#!/bin/bash

# Read environment variables

# Replace configuration options with environment variables
sed -i "s/port = [0-9]\+/port = $PORT/" config_file.conf
sed -i "s/slots = [0-9]\+/slots = $SLOTS/" config_file.conf
sed -i "s/password = \".*\"/password = \"$PASSWORD\"/" config_file.conf
sed -i "s/maxClientLatencySeconds = [0-9]\+/maxClientLatencySeconds = $MAX_LATENCY/" config_file.conf
sed -i "s/pauseWhenEmpty = .*$/pauseWhenEmpty = $PAUSE/" config_file.conf
sed -i "s/giveClientsPower = .*$/giveClientsPower = $GIVE_CLIENTS_POWER/" config_file.conf
sed -i "s/logging = .*$/logging = $LOGGING/" config_file.conf
sed -i "s/language = .*/language = $LANGUAGE/" config_file.conf
sed -i "s/zipSaves = .*$/zipSaves = $ZIP_SAVES/" config_file.conf
sed -i "s/MOTD = \".*\"/MOTD = \"$MOTD\"/" config_file.conf

# Override SteamCMD launch arguments if necessary
# Used for subscribing to betas or for testing
if [ -z "$STEAMCMD_UPDATE_ARGS" ]; then
        bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "$STEAMAPPDIR" +login anonymous +app_update "$STEAMAPPID" +quit
else
        steamcmd_update_args=($STEAMCMD_UPDATE_ARGS)
        bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "$STEAMAPPDIR" +login anonymous +app_update "$STEAMAPPID" "${steamcmd_update_args[@]}" +quit
fi

#switch to steam application directory
cd "${STEAMAPPDIR}" || exit

#launch server with any additional arguments
"./StartServer-nogui.sh" -localdir \
        {{ADDITIONAL_ARGS}}