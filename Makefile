config:
	chomd +x build.sh && ./build.sh
up:
	npm run up
down:
	docker-compose down
log-server:
	docker logs -f api-container
shell:
	docker exec -it api-container /bin/sh
mongo: # mongod
	docker exec -it mongo-container /bin/sh 