config:
	chmod +x build.sh && ./build.sh
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
restore:
	chmod +x sh/mongo/restore.sh && sh/mongo/restore.sh
backup:
	chmod +x sh/mongo/backup.sh && sh/mongo/backup.sh
mongo_setup:
	chmod +x sh/mongo/setup.sh && sh/mongo/setup.sh
mongo_up:
	docker-compose up -d mongo_service