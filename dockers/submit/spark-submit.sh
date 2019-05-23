#!/bin/bash
 
/spark/bin/spark-submit \
--master ${SPARK_MASTER_URL} \
--total-executor-cores 3 \
${SPARK_APPLICATION_PYTHON_LOCATION} \

