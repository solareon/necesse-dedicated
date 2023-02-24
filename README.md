# Docker container for linux necesse dedicated server
Based upon steamcmd. Supports modifying server config via environment variables in addition to manual changes to the server.cfg

[![Docker Pulls](https://badgen.net/docker/pulls/solareon/necesse-dedicated?icon=docker&label=pulls)](https://hub.docker.com/r/solareon/necesse-dedicated) 
[![Docker Stars](https://badgen.net/docker/stars/solareon/necesse-dedicated?icon=docker&label=stars)](https://hub.docker.com/r/solareon/necesse-dedicated) 
[![Docker Image Size](https://badgen.net/docker/size/solareon/necesse-dedicated?icon=docker&label=image%20size)](https://hub.docker.com/r/solareon/necesse-dedicated) 
![Github stars](https://badgen.net/github/stars/solareon/necesse-dedicated?icon=github&label=stars) 
![Github forks](https://badgen.net/github/forks/solareon/necesse-dedicated?icon=github&label=forks) 
![Github issues](https://img.shields.io/github/issues/solareon/necesse-dedicated)
![Github last-commit](https://img.shields.io/github/last-commit/solareon/necesse-dedicated)

# Necesse Dedicated Server Instructions
The Necesse Dedicated Server is as it sounds a dedicated server application running inside Docker for the game [Necesse](https://store.steampowered.com/app/1169040/Necesse/).

# Running the Server
There are two methods to run the server. Docker Compose is the recommended version as it will all you to easily modify environment variables and restart/shutdown your server without remembering a complicated command line

### docker compose

```
version: "3"
services: 
  necesse:
    container_name: necesse-server
    image: solareon/necesse-dedicated:latest
    volumes: 
      - ~/necesse/config:/necesse/cfg
      - ~/necesse/saves:/necesse/saves
    environment:
      - "TZ=Europe/Berlin"
      - WORLD=world #not currently used
      - PORT=14159
      - SLOTS=10
      - "MOTD=A Necesse server powered by Docker!"
      - "PASSWORD="
      - PAUSE=true
      - GIVE_CLIENTS_POWER=false
      - MAX_LATENCY=30
      - LOGGING=true
      - "LANGUAGE=en"
      - ZIP_SAVES=true
      - "ADDITIONAL_ARGS=" #optional
      - "STEAMCMD_UPDATE_ARGS="" #optional
    ports: 
      - "14159/udp"
    restart: unless-stopped
```

### docker cli
```
    docker run -d --name='necesse-server' \
    -e "TZ=Europe/Berlin" \
    -e WORLD=world \
    -e PORT=14159 \
    -e SLOTS=10 \
    -e "MOTD=A Necesse server powered by Docker!" \
    -e "PASSWORD=" \
    -e PAUSE=true \
    -e GIVE_CLIENTS_POWER=false \
    -e MAX_LATENCY=30 \
    -e LOGGING=true \
    -e "LANGUAGE=en" \
    -e ZIP_SAVES=true \
    -e "ADDITIONAL_ARGS=" \
    -e "STEAMCMD_UPDATE_ARGS="" \
    -v './necesse-server/config':'/necesse/cfg':'rw' \
    -v './necesse-server/saves':'/necesse/saves':'rw' \
    -p 14159:14159/udp \
    'solareon/necesse-dedicated:latest'
```

# Configuring the Server
There is a main settings files that the server is using.
* `server.cfg`

Note: server.cfg is overwritten on startup using information from server variables. If you do not define the environment variables they will be filled with the defaults from the table below.

# Environment Variables
The most important settings exposed as environment variables are the following:

| Setting | Value Type | Example Value | Comment |
|----------|:-------------:|:------:|---|
| WORLD | string | "world" | Name of server save file. |
| MOTD | string | "This is a my Necesse dedicated server" | Short description of server purpose, rules, message of the day. |
| PORT | number | 14159 | UDP port for game traffic. |
| SLOTS | number | 10 | Max number of concurrent players on server. |
| PASSWORD | string | "" | Set a password or leave empty. |
| PAUSE | boolean | true | Pauses server when no users are connected. |
| GIVE_CLIENTS_POWER | boolean | true | If true, clients will have much more power over what hits them, their position etc |
| LOGGING | boolean | true | If true, will create log files for each server start |
| ZIP_SAVES | boolean | true | If true, will create new saves compressed |
| MAX_LATENCY | number | 30 | Maximum client latency? |
| LANGUAGE | string | "en" | Specify server language, should be two letter ISO code for desired language |
| ADDITIONAL_ARGS | string | "" | Optional setting for passing additional command arguments to server launcher |
| STEAMCMD_UPDATE_ARGS | string | "" | Optional setting for passing additional command arguments to steamcmd (beta builds, etc.) |

If you want others to connect to your server, make sure you allow the server through your firewall. You might also need to forward ports on your router. To do this, please follow your manufacturer's instructions for your particular router.

## Backups
It is highly recommended to backup the save files often and before patching or before starting the server after having patched. They are located in the `/necesse/saves/` folder and under the default configuration are stored compressed.