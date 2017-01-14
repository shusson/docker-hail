FROM shusson/docker-hail:latest
MAINTAINER Shane Husson

RUN apt-get update --fix-missing && apt-get install -y wget

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda2-4.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    pip install py4j && \
    rm ~/anaconda.sh

ENV PATH /opt/conda/bin:$PATH

RUN cd /usr/hail && \
    ./gradlew shadowJar && \
    echo 'alias pyhail="PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.3-src.zip:$HAIL_HOME/python SPARK_CLASSPATH=$HAIL_HOME/build/libs/hail-all-spark.jar python"' >> ~/.bashrc

CMD [ "/bin/bash" ]
