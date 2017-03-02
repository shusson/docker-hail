FROM openjdk:8u111-jdk-alpine
MAINTAINER Shane Husson shane.a.husson@gmail.com

RUN apk add --update \
    bash \
    cmake \
    curl \
    g++ \
    git \
    gzip \
    make \
    libc6-compat \
    tar

ENV SPARK_HOME=/usr/spark/spark-2.1.0-bin-hadoop2.7 \
    HAIL_HOME=/usr/hail \
    PATH=$PATH:/usr/spark/spark-2.1.0-bin-hadoop2.7/bin:/usr/hail/build/install/hail/bin/

RUN mkdir /usr/spark && \
    curl -sL --retry 3 \
    "http://apache.mirror.serversaustralia.com.au/spark/spark-2.1.0/spark-2.1.0-bin-hadoop2.7.tgz" \
    | gzip -d \
    | tar x -C /usr/spark && \
    chown -R root:root $SPARK_HOME

RUN git clone https://github.com/broadinstitute/hail.git ${HAIL_HOME} && \
    cd ${HAIL_HOME} && \
    git checkout fed768e78ac2ca06a50b6e1965d59d04d5a78e3e && \
    ./gradlew installDist

ENTRYPOINT ["hail"]
CMD ["-h"]
