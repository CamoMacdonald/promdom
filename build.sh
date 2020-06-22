#!/bin/bash

#Build Grafana
docker build --no-cache -t mon_grafana ./grafana

#Build Prometheus
docker build --no-cache -t mon_prom ./prometheus

#Build Blackbox
docker build --no-cache -t mon_blackbox ./blackbox

#Build Alertmanager
source .env
sed -i "s/GF_SMTP_HOST/${GF_SMTP_HOST}/g" ./alertmanager/src/alertmanager.yml
sed -i "s/GF_SMTP_FROM_ADDRESS/${GF_SMTP_FROM_ADDRESS}/g" ./alertmanager/src/alertmanager.yml
sed -i "s/GF_SMTP_USER/${GF_SMTP_USER}/g" ./alertmanager/src/alertmanager.yml
sed -i "s/GF_SMTP_PASSWORD/${GF_SMTP_PASSWORD}/g" ./alertmanager/src/alertmanager.yml
sed -i "s/GF_SMTP_TO_ADDRESS/${GF_SMTP_TO_ADDRESS}/g" ./alertmanager/src/alertmanager.yml
docker build --no-cache -t mon_alerts ./alertmanager

#Insert into stackfile
sed -i "s/CERT_NAME/${CERT_NAME}/g" monitoring.yml
sed -i "s/GRAFANA_DOMAIN/${GRAFANA_DOMAIN}/g" monitoring.yml
sed -i "s/PROM_DOMAIN/${PROM_DOMAIN}/g" monitoring.yml
sed -i "s/BOX_DOMAIN/${BOX_DOMAIN}/g" monitoring.yml
sed -i "s/ALERT_DOMAIN/${ALERT_DOMAIN}/g" monitoring.yml
