# syntax=docker/dockerfile-upstream:1.4

FROM --platform=${BUILDPLATFORM} debian:bullseye-slim AS cloud-datastore-emulator

ARG DATASTORE_EMULATOR_BUILD_NUMBER
ENV DATASTORE_EMULATOR_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/components/google-cloud-sdk-cloud-datastore-emulator-${DATASTORE_EMULATOR_BUILD_NUMBER}.tar.gz"
RUN apt-get update && \
  apt-get -y install \
    curl \
    bash \
    openjdk-11-jre-headless && \
	\
	curl -sSL ${DATASTORE_EMULATOR_URL} | tar xfz - --strip-components=1 -C /

WORKDIR /cloud-datastore-emulator
EXPOSE 8080/tcp
ENTRYPOINT ["cloud_datastore_emulator"]

LABEL org.opencontainers.image.authors       "The containerz authors"
LABEL org.opencontainers.image.url           "https://github.com/containerz-dev/cloud-datastore-emulator"
LABEL org.opencontainers.image.source        "https://github.com/containerz-dev/cloud-datastore-emulator/Dockerfile"
LABEL org.opencontainers.image.documentation "Cloud SDK less cloud datastore emulator container image"
LABEL org.opencontainers.image.base.name     "debian:bullseye-slim"
LABEL org.opencontainers.image.version       "${DATASTORE_EMULATOR_BUILD_NUMBER}"
LABEL org.opencontainers.image.licenses      "BSD-3-Clause"
