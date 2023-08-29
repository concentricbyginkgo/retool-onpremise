FROM tryretool/backend:2.103.11

CMD ./docker_scripts/start_api.sh

RUN apt-get - y update
RUN apt-get libcap2-bin

ENV  NRIA_MODE=UNPRIVILEGED

RUN apt-get install newrelic-infra
