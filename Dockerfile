FROM tryretool/backend:3.8.4
CMD ./docker_scripts/start_api.sh
CMD ["yarn", "add", "newrelic"]
