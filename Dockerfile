# syntax=docker/dockerfile-upstream:1.4

ARG OPENJDK_VERSION
FROM --platform=${BUILDPLATFORM} amazoncorretto:${OPENJDK_VERSION} AS cloud-datastore-emulator

ARG DATASTORE_EMULATOR_BUILD_NUMBER
ENV DATASTORE_EMULATOR_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/components/google-cloud-sdk-cloud-datastore-emulator-${DATASTORE_EMULATOR_BUILD_NUMBER}.tar.gz"
RUN set -eux; \
	apk --no-cache add \
		bash; \
	\
	wget -q -O- ${DATASTORE_EMULATOR_URL} | tar xfz - --strip-components=1 -C /

WORKDIR /cloud-datastore-emulator
EXPOSE 8080/tcp
ENTRYPOINT ["cloud_datastore_emulator"]

LABEL org.opencontainers.image.authors       "The containerz authors"
LABEL org.opencontainers.image.url           "https://github.com/containerz-dev/cloud-datastore-emulator"
LABEL org.opencontainers.image.source        "https://github.com/containerz-dev/cloud-datastore-emulator/Dockerfile"
LABEL org.opencontainers.image.documentation "Cloud SDK less cloud datastore emulator container image"
LABEL org.opencontainers.image.base.name     "adoptopenjdk/openjdk11:${OPENJDK_TAG}"
LABEL org.opencontainers.image.version       "${DATASTORE_EMULATOR_BUILD_NUMBER}"
LABEL org.opencontainers.image.licenses      "BSD-3-Clause"
