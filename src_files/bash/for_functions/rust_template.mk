all: target/debug/FILE_NAME
	target/debug/FILE_NAME

target/debug/FILE_NAME: src/main.rs
	cargo build
