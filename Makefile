config:
	chomd +x build.sh && ./build.sh
up:
	npm run up
down:
	docker-compose down
log-server:
	docker logs -f api-container