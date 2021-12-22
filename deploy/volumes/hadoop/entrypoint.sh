#!/bin/bash

set -e

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
  hdfs datanode &
  exec yarn nodemanager
else
  echo "Do not add to cluster."
fi

exec $@
