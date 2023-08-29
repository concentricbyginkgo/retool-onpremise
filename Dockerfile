FROM tryretool/backend:2.103.11

CMD ./docker_scripts/start_api.sh

RUN apt-get - y update  && \
      apt-get -y install sudo
RUN sudo apt-get -y install curl
RUN curl -fsSL https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/newrelic-infra.gpg
RUN echo "deb https://download.newrelic.com/infrastructure_agent/linux/apt buster main" | sudo tee -a /etc/apt/sources.list.d/newrelic-infra.list
RUN sudo apt-get update
RUN sudo apt-get install newrelic-infra -y
