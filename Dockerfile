FROM tryretool/backend:3.8.4
USER root

RUN apt-get - y update
RUN apt-get libcap2-bin

ENV  NRIA_MODE=UNPRIVILEGED

RUN apt-get install newrelic-infra
CMD ./docker_scripts/start_api.sh
