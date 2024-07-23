config:
	chomd +x build.sh && ./build.sh
up:
	npm run up
down:
	docker-compose down
server-log:
	docker logs -f api-container