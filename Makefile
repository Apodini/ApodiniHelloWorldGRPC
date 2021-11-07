.PHONY: all clean generate pull

all: pull generate

pull:
	curl --insecure https://127.0.0.1:8080/apodini/proto > webservice.proto

generate:
	protoc --swift_out=./Sources/HelloWorldClient --grpc-swift_out=./Sources/HelloWorldClient webservice.proto \
		--grpc-swift_opt=ExperimentalAsyncClient=true,Server=false # Enable async client and disable server generation

clean:
	rm webservice.proto
	rm Sources/HelloWorldClient/webservice.grpc.swift
	rm Sources/HelloWorldClient/webservice.pb.swift
