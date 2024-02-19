FROM rust:alpine3.19 AS builder

WORKDIR /usr/src/app

COPY Cargo.lock ./
COPY Cargo.toml ./
COPY src ./src

RUN rustup toolchain install nightly
RUN rustup component add rust-src --toolchain nightly
RUN rustup target add x86_64-unknown-linux-musl
RUN cargo +nightly build -Z build-std=std,panic_abort -Z build-std-features=panic_immediate_abort \
    --target x86_64-unknown-linux-musl --release

FROM scratch

ENV HOST 0.0.0.0
ENV PORT 8080

COPY --from=builder /usr/src/app/target/x86_64-unknown-linux-musl/release/nano-http-ok /nano-http-ok

CMD ["/nano-http-ok"]
