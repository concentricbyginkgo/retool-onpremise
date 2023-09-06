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
         "@type forward\n" \
         "port 24224\n" \
         "bind 0.0.0.0\n" \
         "tag retool.service\n" \
         "</source>\n\n" \
         "<label @FLUENT_LOG>\n" \
         "\t<filter retool.service>\n" \
         "\t\t@type record_transformer\n" \
         "\t\t<record>\n" \
	 "\t\t\tservice_name retool.service\n" \
	 "\t\t\thostname '#{Socket.gethostname}'\n" \
         "\t\t</record>\n" \
         "\t</filter>\n" \
         "\t<match retool.*>\n" \
         "\t\t@type newrelic\n" \
         "\t\tlicense_key \"#{ENV['NEW_RELIC_LICENSE_KEY']}\"\n" \
	 "\t</match>\n" \
         "</label>"  > /etc/fluent/fluent.conf
USER retool_user
CMD ./docker_scripts/start_api.sh


