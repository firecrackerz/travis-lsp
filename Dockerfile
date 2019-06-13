FROM satishbabariya/swift:5.0.1 as lsp-builder

RUN apt-get -q update && \
    apt-get -q install -y \
    sqlite3 \
    libsqlite3-dev \
    libblocksruntime-dev

# Download and Build Sourcekit-LSP
RUN git clone --depth 1 https://github.com/apple/sourcekit-lsp
WORKDIR /sourcekit-lsp
RUN swift build -c release -Xcxx -I/usr/lib/swift && mv /sourcekit-lsp/.build/release/ /release
# RUN swift build -Xcxx -I/usr/lib/swift -I/usr/lib/swift/Block && mv `swift build --show-bin-path`/sourcekit-lsp /usr/bin/
RUN chmod -R o+r /release