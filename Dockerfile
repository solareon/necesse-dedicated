###########################################################
# Dockerfile that builds a Necesse Gameserver
###########################################################
FROM cm2network/steamcmd:root

ENV STEAMAPPID 1169370
ENV STEAMAPP necesse
ENV STEAMAPPDIR "/${STEAMAPP}"

ENV WORLD="world" \
    PORT=14159 \
    SLOTS=10 \
    MOTD="This server is made possible by Docker!" \
    PASSWORD="" \
    PAUSE=true \
    GIVE_CLIENTS_POWER=true \
    MAX_LATENCY=30\
    LOGGING=true \
    LANGUAGE="en" \
    ZIP_SAVES=true \
    ADDITIONAL_ARGS="" \
    STEAMCMD_UPDATE_ARGS=""

RUN mkdir ${STEAMAPPDIR}

COPY server.cfg ${STEAMAPPDIR}/cfg/

RUN chown steam:steam -R ${STEAMAPPDIR}

# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

COPY entry.sh .

# Overwrite Stopsignal for graceful server exits
STOPSIGNAL SIGINT

ENTRYPOINT ["bash", "entry.sh"]

# Expose ports
EXPOSE 14159/udp
