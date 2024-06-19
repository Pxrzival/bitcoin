FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libtool \
    autotools-dev \
    automake \
    pkg-config \
    bsdmainutils \
    python3 \
    libevent-dev \
    libboost-system-dev \
    libboost-filesystem-dev \
    libboost-chrono-dev \
    libboost-test-dev \
    libboost-thread-dev \
    libssl-dev \
    libdb-dev \
    libdb++-dev \
    libminiupnpc-dev \
    libzmq3-dev \
    git

# Clone bitcoin source code
RUN git clone https://github.com/bitcoin/bitcoin.git /root/.bitcoin
WORKDIR /root/.bitcoin

# Build Bitcoin Core
RUN ./autogen.sh && \
    ./configure && \
    make && \
    make install

# Expose ports for bitcoind
EXPOSE 8333 8332

# Run bitcoind by default
CMD ["bitcoind", "-printtoconsole"]
