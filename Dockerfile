ARG IMAGE=store/intersystems/iris-community-arm64:2021.1.0.215.3
ARG IMAGE=store/intersystems/iris-community-arm64:2021.2.0.649.0
ARG IMAGE=store/intersystems/iris-community:2021.1.0.215.3
ARG IMAGE=store/intersystems/iris-community:2021.2.0.649.0
FROM $IMAGE

ARG COMMIT_ID="dwhbench"

USER root   
        
ENV ISC_TEMP_DIR=/intersystems/iris/dwh

USER ${ISC_PACKAGE_MGRUSER}

COPY src/dwh/ $ISC_TEMP_DIR/
COPY src/dwh/DWH $ISC_TEMP_DIR/DWH
COPY src/dwh/Sample $ISC_TEMP_DIR/Sample
COPY src/dwh/WebTerminal $ISC_TEMP_DIR/WebTerminal
COPY iris.script /tmp/iris.script

USER root

RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /intersystems/iris/dwh

USER ${ISC_PACKAGE_MGRUSER}

RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script \
    && iris stop IRIS quietly
