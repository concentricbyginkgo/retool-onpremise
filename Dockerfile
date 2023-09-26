FROM tryretool/backend:2.103.11

USER root

ENV NEW_RELIC_API_KEY=
ENV NEW_RELIC_ACCOUNT_ID=3414545
RUN apt-get update && \
    apt-get install -y curl sudo libcap2-bin gnupg
RUN echo "license_key: ${NEW_RELIC_API_KEY}" | tee -a /etc/newrelic-infra.yml && \
    curl -fsSL https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/newrelic-infra.gpg && \
    echo "deb https://download.newrelic.com/infrastructure_agent/linux/apt buster main" | tee -a /etc/apt/sources.list.d/newrelic-infra.list

# This does not work because systemctl is not installed and if it were, its not the default init system
# I've entered an NR support ticket to understand how to get this working within a container
# RUN apt-get update && NRIA_MODE="UNPRIVILEGED" apt-get install -y newrelic-infra

# These won't work, but here for context
# sudo systemctl <start|stop|restart|status> newrelic-infra
# RUN systemctl status newrelic-infra

# this must be uncommented before merge but commented out to allow sudo testing in the container
# USER retool_user

COPY ./start_api.sh ./logging.yml /retool_backend/

CMD ./start_api.sh
