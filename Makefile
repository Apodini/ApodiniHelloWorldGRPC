.PHONY: all clean generate pull

all: pull generate

pull:
	curl --insecure https://127.0.0.1:8080/apodini/proto > webservice.proto

generate:
	protoc --swift_out=./Sources/_PB_GENERATED --grpc-swift_out=./Sources/_GRPC_GENERATED webservice.proto \
		--grpc-swift_opt=ExperimentalAsyncClient=true,Server=false,Visibility=Public \
		--swift_opt=Visibility=Public \
		--grpc-migrator_out=./Sources/HelloWorldClient/Migrator

clean:
	rm webservice.proto
	rm Sources/GRPC.SWIFT/webservice.grpc.swift
	rm Sources/PB.SWIFT/webservice.pb.swift

testfile:
	protoc --swift_out=Sources/HelloWorldClient --swift_opt=Visibility=Public test.proto
