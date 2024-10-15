FROM python:3.12.7-slim
ENV PYTHONBUFFORED 1
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-17-amd64/
ENV SPARK_HOME=/opt/spark
ENV PATH="$PATH:$JAVA_HOME/bin:$SPARK_HOME/bin"
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk wget curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN wget -q https://archive.apache.org/dist/spark/spark-3.3.0/spark-3.3.0-bin-hadoop3.tgz && \
    tar -xzf spark-3.3.0-bin-hadoop3.tgz -C /opt/ && \
    mv /opt/spark-3.3.0-bin-hadoop3 /opt/spark && \
    rm spark-3.3.0-bin-hadoop3.tgz
COPY requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt
COPY . /app