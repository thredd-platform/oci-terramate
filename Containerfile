FROM docker.io/alpine:3 AS build
ARG TARGETARCH
ARG TERRAMATE_VERSION=0.17.3

RUN apk add curl ca-certificates tar gzip

RUN --mount=type=tmpfs,target=/tmp \
    case "${TARGETARCH}" in \
    "amd64")  ARCH="x86_64" ;; \
    "arm64")  ARCH="arm64" ;; \
    *) echo "Unsupported architecture: ${TARGETARCH}"; exit 1 ;; \
    esac && \
    curl -fSsL -o /tmp/terramate.tar.gz \
    "https://github.com/terramate-io/terramate/releases/download/v${TERRAMATE_VERSION}/terramate_${TERRAMATE_VERSION}_linux_${ARCH}.tar.gz" && \
    tar -xzf /tmp/terramate.tar.gz -C /usr/local/bin terramate --no-same-owner

FROM scratch
COPY --from=build /usr/local/bin/terramate /usr/local/bin/terramate
