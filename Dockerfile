FROM alpine:3.7
                                                                                
# Dockerfile Maintainer
MAINTAINER Jan Wagner "waja@cyconet.org"

ARG "BUILD_DATE=unknown"
ARG "BUILD_VERSION=unknown"
ARG "VCS_URL=unknown"
ARG "VCS_REF=unknown"
ARG "VCS_BRANCH=unknown"

# See http://label-schema.org/rc1/ and https://microbadger.com/labels
LABEL org.label-schema.name="sslyze - fast and powerful SSL/TLS server scanner" \
    org.label-schema.description="A Python CLI tool that can analyze the SSL configuration of a server on Alpine Linux based container" \
    org.label-schema.vendor="Cyconet" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.version=$BUILD_VERSION \
    org.label-schema.vcs-url=$VCS_URL \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-branch=$VCS_BRANCH

ENV SSLYZE_CLI_VERSION 1.1.5

RUN apk --no-cache update && apk --no-cache upgrade && \
 apk --no-cache add python3 openssl && \
 apk --no-cache add --virtual build-dependencies python3-dev libffi-dev openssl-dev build-base wget && \
 pip3 install sslyze==$SSLYZE_CLI_VERSION && \
 apk del build-dependencies

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

CMD ["sslyze"]
