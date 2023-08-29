FROM tryretool/backend:2.103.11
USER root

CMD ./docker_scripts/start_api.sh

RUN apt-get - y update
RUN apt-get -y install curl
RUN curl -fsSL https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/newrelic-infra.gpg
RUN echo "deb https://download.newrelic.com/infrastructure_agent/linux/apt buster main" | tee -a /etc/apt/sources.list.d/newrelic-infra.list
RUN apt-get update
RUN apt-get install newrelic-infra -y
