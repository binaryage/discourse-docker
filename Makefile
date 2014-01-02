all:
	echo

build:
	sudo docker build -t srid/discourse discourse
	sudo docker build -rm -t "srid/postgresql:9.1" postgresql
	sudo docker build -rm -t "srid/redis:2.6" redis
	sudo docker build -rm -t "srid/discourse-nginx:1.3" nginx
	sudo docker images | grep srid

build-discourse-only:
	sudo docker build -t srid/discourse discourse
	sudo docker images | grep srid/discourse

pull:
	sudo docker pull srid/discourse-nginx
	sudo docker pull srid/redis
	sudo docker pull srid/postgresql
	sudo docker pull srid/discourse

push:
	sudo docker push srid/discourse-nginx
	sudo docker push srid/redis
	sudo docker push srid/postgresql
	sudo docker push srid/discourse

ps:
	sudo docker ps 

supervisor:
	sudo `which supervisord` -n -c etc/supervisord.conf
	
run:
	sudo docker rm discourse-docker-nginx
	sudo docker rm discourse-docker-redis
	sudo docker rm discourse-docker-postgresql
	sudo docker rm discourse-docker-sidekiq
	sudo docker rm discourse-docker-web
	bin/nginx-start
	bin/redis-start
	bin/postgresql-start
	bin/discourse-start sidekiq
	bin/discourse-start web

start:
	sudo docker start discourse-docker-postgresql
	sudo docker start discourse-docker-redis
	sudo docker start discourse-docker-sidekiq
	sudo docker start discourse-docker-web
	sudo docker start discourse-docker-nginx

stop:
	sudo docker stop discourse-docker-nginx
	sudo docker stop discourse-docker-sidekiq
	sudo docker stop discourse-docker-web
	sudo docker stop discourse-docker-redis
	sudo docker stop discourse-docker-postgresql

info:
	bin/nginx-info
