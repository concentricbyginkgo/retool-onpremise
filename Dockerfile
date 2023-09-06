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
         "\ttag retool.service\n" \
         "\t</source>\n\n" \
         "\t<filter retool.service>\n" \
         "<filter retool.service>\n" \
         "\t@type record_transformer\n" \
         "\t<record>\n" \
	 "\t\tservice_name retool.service\n" \
	 "\t\thostname '#{Socket.gethostname}'\n" \
         "\t</record>\n" \
         "</filter>\n" \
         "<match **>\n" \
         "\t@type newrelic\n" \
         "\tlicense_key \"#{ENV['NEW_RELIC_LICENSE_KEY']}\"\n" \
	 "\ttype_name retool-container-logs\n" \
	 "</match>" > /etc/fluent/fluent.conf
USER retool_user
CMD ./docker_scripts/start_api.sh


