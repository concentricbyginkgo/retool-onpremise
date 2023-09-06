FROM tryretool/backend:3.8.4
USER root

RUN apt-get update
RUN apt-get install -y ruby-full
RUN apt-get install -y ruby-dev
RUN apt-get install make
RUN gem install fluent-plugin-newrelic

CMD ./docker_scripts/start_api.sh


