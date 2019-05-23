FROM spark-docker:2.4.3

COPY spark-submit.sh /

ENV SPARK_MASTER_URL=spark://spark-master:7077

ENV SPARK_APPLICATION_PYTHON_LOCATION=/mnt/spark-apps/spark_and_bot_docker.py


CMD ["/bin/bash", "/spark-submit.sh"]
