# syntax=docker/dockerfile:1.4
FROM ubuntu:26.04 as app

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV MINER_URL https://github.com/ADA-Markets/midnight_fetcher_bot_public.git
ENV MINER_REV e886246a14555182e6d9a3b9bb8ce29c4cf45be6

# Dependencies
RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get -y install git bash ca-certificates curl
RUN apt-get -y install build-essential pkg-config libssl-dev
RUN apt-get -y install rustc cargo
RUN apt-get -y install nodejs npm
RUN apt-get clean

# Certs
RUN update-ca-certificates

# Clone miner
RUN git clone --revision=$MINER_REV $MINER_URL /app

# Prepare hash-engine
WORKDIR /app/hashengine
RUN export RUSTFLAGS="-C target-cpu=native -C panic=abort"
RUN cargo build --release --bin hash-server

# Prepare web-ui
WORKDIR /app
RUN mkdir /root/Documents
RUN mkdir -p {secure,storage,logs}
RUN npm install
RUN npm run build

COPY startup.sh /app/startup.sh

ENTRYPOINT ["/app/startup.sh"]
