# syntax=docker/dockerfile:1.4

FROM maven@sha256:e13f86d46dc9504853f19083674f608dfe2bb0ca95db508b36c5d923888480ad as builder

ARG PACKAGE_PATH=/root/.m2/repository/gov/nist/secauto/oscal/tools/oscal-cli/cli-core/0.0.2-SNAPSHOT
ARG PACKAGE_FILE=cli-core-0.0.2-SNAPSHOT-oscal-cli.tar.bz2
ARG INSTALL_PATH=/opt/oscal-cli

RUN mkdir -p /usr/local/app

COPY ./vendor /usr/local/app/vendor

RUN (cd /usr/local/app/vendor/metaschema-java && mvn install) && \
    (cd /usr/local/app/vendor/liboscal-java && mvn install) && \
    (cd /usr/local/app/vendor/oscal-cli && mvn install && mvn pacakge)

FROM maven@sha256:e13f86d46dc9504853f19083674f608dfe2bb0ca95db508b36c5d923888480ad

ARG PACKAGE_PATH
ARG PACKAGE_FILE
ARG INSTALL_PATH

COPY --from=builder ${PACKAGE_PATH}/${PACKAGE_FILE} /tmp

RUN mkdir -p ${INSTALL_PATH} && \
    tar xvjf /tmp/${PACKAGE_FILE} -C ${INSTALL_PATH} && \
    rm -rf /tmp/${PACKAGE_FILE}

ENTRYPOINT ["${INSTALL_PATH}/bin/oscal-cli"]
