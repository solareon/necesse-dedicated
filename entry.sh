#!/bin/bash

# Override SteamCMD launch arguments if necessary
# Used for subscribing to betas or for testing
if [ -z "$STEAMCMD_UPDATE_ARGS" ]; then
        bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "$STEAMAPPDIR" +login anonymous +app_update "$STEAMAPPID" +quit
else
        steamcmd_update_args=($STEAMCMD_UPDATE_ARGS)
        bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "$STEAMAPPDIR" +login anonymous +app_update "$STEAMAPPID" "${steamcmd_update_args[@]}" +quit
fi

# Set config file
CONFIG_FILE=${STEAMAPPDIR}/cfg/server.cfg

# Replace configuration options with environment variables
sed -i "s/port = [0-9]\+/port = $PORT/" "$CONFIG_FILE"
sed -i "s/slots = [0-9]\+/slots = $SLOTS/" "$CONFIG_FILE"
sed -i "s/password = \".*\"/password = $PASSWORD/" "$CONFIG_FILE"
sed -i "s/maxClientLatencySeconds = [0-9]\+/maxClientLatencySeconds = $MAX_LATENCY/" "$CONFIG_FILE"
sed -i "s/pauseWhenEmpty = .*$/pauseWhenEmpty = $PAUSE/" "$CONFIG_FILE"
sed -i "s/giveClientsPower = .*$/giveClientsPower = $GIVE_CLIENTS_POWER/" "$CONFIG_FILE"
sed -i "s/logging = .*$/logging = $LOGGING/" "$CONFIG_FILE"
sed -i "s/language = .*/language = $LANGUAGE/" "$CONFIG_FILE"
sed -i "s/zipSaves = .*$/zipSaves = $ZIP_SAVES/" "$CONFIG_FILE"
sed -i "s/MOTD = .*$/MOTD = $MOTD/" "$CONFIG_FILE"

#switch to steam application directory
cd "${STEAMAPPDIR}" || exit

#launch server with any additional arguments
"./StartServer-nogui.sh" -localdir \
        -world "${WORLD}" \
        "${ADDITIONAL_ARGS}"