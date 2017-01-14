FROM openjdk:8u111-jdk
MAINTAINER Shane Husson shane.a.husson@gmail.com

RUN apt-get update --fix-missing && apt-get install -y \
  cmake \
  g++ \
  git

RUN mkdir /usr/spark
RUN curl -sL --retry 3 \
  "http://apache.mirror.serversaustralia.com.au/spark/spark-2.1.0/spark-2.1.0-bin-hadoop2.7.tgz" \
  | gunzip \
  | tar x -C /usr/spark

ENV SPARK_HOME /usr/spark/spark-2.1.0-bin-hadoop2.7
ENV PATH $PATH:${SPARK_HOME}/bin
RUN chown -R root:root $SPARK_HOME

RUN git clone https://github.com/broadinstitute/hail.git /usr/hail
RUN cd /usr/hail && ./gradlew installDist

ENV HAIL_HOME=/usr/hail
ENV PATH $PATH:${HAIL_HOME}/build/install/hail/bin/

ENTRYPOINT ["hail"]
CMD ["-h"]
