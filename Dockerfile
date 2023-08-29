FROM newrelic/infrastructure:latest
# ADD newrelic-infra.yml /etc/newrelic-infra.yml


FROM tryretool/backend:3.8.4

CMD ./docker_scripts/start_api.sh

#USER root

#RUN rm -rf /var/lib/apt/lists/*

#RUN apt-get -y update
#RUN apt-get -y install curl
#RUN apt-get -y install gpg
#RUN curl -fsSL https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/newrelic-infra.gpg
#RUN echo "deb https://download.newrelic.com/infrastructure_agent/linux/apt buster main" | sudo tee -a /etc/apt/sources.list.d/newrelic-infra.list
#RUN apt-get -y update

#RUN apt-get -y install newrelic-infra
