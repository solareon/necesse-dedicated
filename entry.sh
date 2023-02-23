#!/bin/bash
su steam

mkdir -p "${STEAMAPPDIR}" || true

# Override SteamCMD launch arguments if necessary
# Used for subscribing to betas or for testing
if [ -z "$STEAMCMD_UPDATE_ARGS" ]; then
        bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "$STEAMAPPDIR" +login anonymous +app_update "$STEAMAPPID" +quit
else
        steamcmd_update_args=($STEAMCMD_UPDATE_ARGS)
        bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "$STEAMAPPDIR" +login anonymous +app_update "$STEAMAPPID" "${steamcmd_update_args[@]}" +quit
fi

cd "${STEAMAPPDIR}"

"./StartServer-nogui.sh" -localdir \
  -world ${WORLD} \
  -slots ${SLOTS} \
  -motd "${MOTD}" \
  -password "${PASSWORD}" \
  -pausewhenempty ${PAUSE} \
  -giveclientspower ${GIVE_CLIENTS_POWER} \
  -logging ${LOGGING} \
  -zipsaves ${ZIP}
                
