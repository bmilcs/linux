rm -rf /tmp/docker 
git clone git@github.com:bmilcs/docker.git /tmp/docker
rm -f ~/docker/docker-compose.yaml ~/docker/.env
cp /tmp/docker/1docker-compose.yaml /tmp/docker/.env ~/docker/
cd ~/docker
mv ~/docker/1docker-compose.yaml ~/docker/docker-compose.yaml
(cd ~/docker ; docker-compose up -d --remove-orphans)