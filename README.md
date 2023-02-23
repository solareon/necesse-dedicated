# necesse-dedicated
Dedicated server for Necesse using steamcmd

Example docker-compose

  ```
  necesse-server:
    image: solareon/necesse-dedicated:latest
    container_name: necesse-server
    environment:
      - "PASSWORD=password"
    volumes:
      - ./necesse/config:/home/steam/necesse-dedicated/cfg
      - ./necesse/saves:/home/steam/necesse-dedicated/saves
    ports:
      - "14159:14159/udp"
    restart: unless-stopped
