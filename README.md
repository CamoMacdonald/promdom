# Uptime

## Requirements
- Docker
- Docker Swarm
- Git

### Deploying

Clone down the repo
``git clone https://github.com/CamoMacdonald/uptime.git /monitoring``

cd into montioring directory
``cd /monitoring``

Make required directories
``mkdir -p ./data/ssl ./data/grafana ./data/prometheus``
``chown 472:472 ./data/grafana ; chmod 775 ./data/grafana``
``chown nobody:nobody ./data/prometheus ; chmod 775 ./data/prometheus``

Add SSL Certs into ./data/ssl
`` nano ./data/ssl/example.com.crt``
`` nano ./data/ssl/example.com.key``

Copy the ENV
``cp .env_dist .env``
``nano .env``

Add domains to targets
``nano ./prometheus/src/targets.yml``

Build the Images
``bash ./build.sh``

Deploy
``docker stack deploy -c monitoring.yml monitoring``

### Updating

reset any changes
``git reset --hard``

check for any .env_dist changes

rebuild images
``bash ./build.sh``

Redeploy
``docker stack rm monitoring``
``docker stack deploy -c monitoring.yml monitoring``