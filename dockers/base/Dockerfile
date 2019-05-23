FROM rtfpessoa/ubuntu-jdk8


# Set up environment variables.
ENV DAEMON_RUN=true
ENV SPARK_VERSION=2.4.3
ENV HADOOP_VERSION=2.7

RUN apt-get update && apt-get install -y software-properties-common ca-certificates wget curl ssh

# Install spark-2.4.3
RUN wget --no-verbose http://apache.mirror.iphh.net/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
      && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark \
&& rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz


# Install miniconda to /miniconda
RUN curl -LO http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
RUN bash Miniconda-latest-Linux-x86_64.sh -p /miniconda -b
RUN rm Miniconda-latest-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}
RUN conda update -y conda

# Conda virtual environment setup
ADD environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml

# Pull the environment name out of the environment.yml
RUN echo "source activate $(head -1 /tmp/environment.yml | cut -d' ' -f2)" > ~/.bashrc
ENV PATH /opt/conda/envs/$(head -1 /tmp/environment.yml | cut -d' ' -f2)/bin:$PATH

EXPOSE 5000

## expose for ssh
EXPOSE 22

## expose for spark use
EXPOSE 7000-8000

## expose for master webui
EXPOSE 8080

## expose for slave webui
EXPOSE 8081

