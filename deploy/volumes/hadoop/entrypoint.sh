#!/bin/bash

set -e

SCRIPT_DIR=$(dirname $(readlink -f $0))

# Link all files from volumes to hadoop config directory.
ln -s -f /volumes/hadoop/* $HADOOP_HOME/etc/hadoop/

if [ "$1" = "master" ]; then
  if [ ! -d "/data/dfs/name" ]; then
    hdfs namenode -format
  fi
  hdfs namenode &
  mapred historyserver &
  exec yarn resourcemanager
elif [ "$1" = "worker" ]; then
  ${SCRIPT_DIR}/wait-for-it.sh hadoop-master:9820 -t 0 -- \
  hdfs datanode &
  ${SCRIPT_DIR}/wait-for-it.sh hadoop-master:8031 -t 0 -- \
  yarn nodemanager
else
  echo "Do not add to cluster."
fi

exec $@
