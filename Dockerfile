FROM tryretool/backend:3.8.4
USER root

RUN apt-get update
RUN apt-get install -y ruby-full
RUN apt-get install -y ruby-dev
RUN apt-get install -y g++
RUN apt-get install make
RUN gem install fluent-plugin-newrelic

RUN mkdir /fluent/etc
RUN mkdir /fluent/conf
RUN touch /fluent/conf/fluent.conf

RUN echo "<source>\n" \
         "\t@type forward\n" \
         "\tport 24224\n" \
         "\tbind 0.0.0.0\n" \
         "\ttag retool.api.service\n" \
         "</source>\n\n" \
         "<filter retool.**>\n" \
         "\t@type record_transformer\n" \
         "\t<record>\n" \
	 "\t\tservice_name api\n" \
	 "\t\thostname app-59963.on-aptible.com\n" \
         "\t</record>\n" \
         "</filter>\n" \
         "<match retool.**>\n" \
         "\t@type newrelic\n" \
         "\tlicense_key \"#{ENV['NEW_RELIC_LICENSE_KEY']}\"\n" \
	 "</match>\n"   > /fluent/conf/fluent.conf
USER retool_user
CMD ./docker_scripts/start_api.sh


