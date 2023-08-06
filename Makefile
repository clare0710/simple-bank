postgres:
	docker run --name postgres15 -p 5434:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=password -d postgres:15-alpine

createdb:
	docker exec -it postgres15 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres15 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:password@localhost:5434/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:password@localhost:5434/simple_bank?sslmode=disable" -verbose down

sqlc:
	docker run --rm -v "C:\Users\user\Desktop\simplebank:/src" -w /src kjconroy/sqlc generate

test: 
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test