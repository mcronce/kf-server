FROM mcronce/steam-game-base:latest

ARG STEAM_LOGIN
ARG STEAM_PASS
ARG STEAM_GUARD

RUN \
	echo "--- Installing Killing Floor server; output is buffered by Docker, so this will take a while with no visibility." && \
	/app/steamcmd +login ${STEAM_LOGIN} ${STEAM_PASS} ${STEAM_GUARD} +force_install_dir /app/killing-floor +app_update 215360 validate +quit && \
	rm -Rvf /root/Steam /app/steamapps
RUN rm -vf /app/killing-floor/System/Default.ini

# I don't know why this we need to run webadmin in UTF-8, but it's in the
#    upstream setup.sh, so we'll keep it - just do it here rather than at run
#    time
RUN sed -i 's/CharSet="iso-8859-1"/CharSet="utf-8"/g' /app/killing-floor/System/UWeb.int
ADD Default.ini /app/killing-floor/System/Default.ini.example
ADD run /app/

EXPOSE \
	7707/udp \
	7708/udp \
	7717/udp \
	28852 \
	28852/udp \
	8075 \
	20560/udp

ENTRYPOINT ["/app/run"]

