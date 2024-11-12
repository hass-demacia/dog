FROM rust as build

WORKDIR /build
COPY /src /build/src
COPY /dns /build/dns
COPY /dns-transport /build/dns-transport
COPY /man /build/man
COPY build.rs Cargo.toml /build/

RUN cargo build --release

FROM rust:slim as deploy

COPY --from=build /build/target/release/dog /dog

ENTRYPOINT ["/dog"]
