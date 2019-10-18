FROM phusion/baseimage:0.10.2

LABEL maintainer="philip@centrifuge.io"
LABEL description="This is the image that underlies the build for substrate-based chains."

RUN apt-get update && \
	apt-get upgrade -y -o Dpkg::Options::="--force-confdef" && \
	apt-get install -y cmake pkg-config libssl-dev git

RUN curl https://getsubstrate.io -sSf | bash -s -- --fast -y

RUN export PATH="$PATH:$HOME/.cargo/bin" && \
	rustup toolchain install nightly && \
	rustup target add wasm32-unknown-unknown --toolchain nightly && \
	cargo install --force --git https://github.com/alexcrichton/wasm-gc && \
	rustup default nightly && \
	rustup default stable
