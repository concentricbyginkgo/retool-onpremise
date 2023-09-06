FROM tryretool/backend:3.8.4
USER root

RUN apt-get update
RUN apt-get install -y ruby-full
RUN apt-get install -y ruby-dev
RUN apt-get install -y g++
RUN apt-get install make
RUN gem install fluent-plugin-newrelic

RUN mkdir /etc/fluent
RUN touch /etc/fluent/fluent.conf

RUN echo "<source>\n" \
         "\t@type forward\n" \
         "\tport 24224\n" \
         "\tbind 0.0.0.0\n" \
         "\ttag retool.api.service\n" \
         "</source>\n\n" \
         "<filter retool.service>\n" \
         "\t@type record_transformer\n" \
         "\t<record>\n" \
	 "\t\tservice_name api\n" \
	 "\t\thostname app-59963.on-aptible.com\n" \
         "\t</record>\n" \
         "</filter>\n" \
         "<match *.**>\n" \
         "\t@type newrelic\n" \
         "\tlicense_key \"#{ENV['NEW_RELIC_LICENSE_KEY']}\"\n" \
	 "</match>\n"   > /etc/fluent/fluent.conf
USER retool_user
CMD ./docker_scripts/start_api.sh


