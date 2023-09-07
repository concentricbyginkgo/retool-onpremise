FROM tryretool/backend:3.8.4
CMD ./docker_scripts/start_api.sh
EXPOSE 24224
EXPOSE 24224/udp
