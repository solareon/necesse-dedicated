###########################################################
# Dockerfile that builds a Necesse Gameserver
###########################################################
FROM cm2network/steamcmd:root

ENV STEAMAPPID 1169370
ENV STEAMAPP necesse
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

ENV WORLD=world \
        SLOTS=10 \
        MOTD="This server is made possible by Docker!" \
        PASSWORD="" \
        PAUSE=true \
        GIVE_CLIENTS_POWER=false \
        LOGGING=true \
        ZIP=true

# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

COPY entry.sh .

RUN mkdir ${STEAMAPPDIR}

RUN chown ${USER}:${USER} ${STEAMAPPDIR}

# Overwrite Stopsignal for graceful server exits
STOPSIGNAL SIGINT

ENTRYPOINT ["bash", "entry.sh"]

# Expose ports
EXPOSE 14159/udp