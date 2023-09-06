FROM tryretool/backend:3.8.4
USER root

RUN apt-get install libgemplugin-ruby
RUN gem install fluent-plugin-newrelic

CMD ./docker_scripts/start_api.sh


