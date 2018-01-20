FROM mcronce/steam-game-base:latest

ARG STEAM_LOGIN
ARG STEAM_PASS
ARG STEAM_GUARD

RUN \
	echo "--- Installing Killing Floor server; output is buffered by Docker, so this will take a while with no visibility." && \
	/app/steamcmd +login ${STEAM_LOGIN} ${STEAM_PASS} ${STEAM_GUARD} +force_install_dir /app/killing-floor +app_update 215360 validate +quit && \
	rm -Rvf /root/Steam /app/steamapps

ADD Default.ini /app/System/
ADD run /app/

EXPOSE \
	7707/udp \
	7708/udp \
	7717/udp \
	28852 \
	28852/udp \
	8075 \
	20560/udp

WORKDIR /app
ENTRYPOINT ["/app/run"]

