#!/bin/bash
set -x

HIVE_DIR=/opt/apache-hive-2.2.0-SNAPSHOT-bin
# kill metastore
ps -ef | grep metastore | grep -v grep | sed 's/\s\s*/ /g' | cut  -d ' ' -f 2 | xargs kill -9
# kill hive server2
ps -ef | grep HiveServer2 | grep -v grep | sed 's/\s\s*/ /g' | cut  -d ' ' -f 2 | xargs kill -9

rm -rf $HIVE_DIR
tar xzvf /tmp/apache-hive-2.2.0-SNAPSHOT-bin.tar.gz -C /opt/
yes | cp hive-site.xml $HIVE_DIR/conf/
yes | cp mysql-connector-java.jar $HIVE_DIR/lib/

echo "" > /tmp/root/hive.log
cp $SPARK_HOME/lib/spark-assembly*.jar $HIVE_HOME/lib/
cp mysql-connector-java.jar  $HIVE_HOME/lib/ 
/opt/apache-hive-2.2.0-SNAPSHOT-bin/bin/hive --service metastore &
