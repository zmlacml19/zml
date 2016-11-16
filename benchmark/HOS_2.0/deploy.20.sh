#!/bin/bash
set -x
source ./base/base_HOS
source ../../conf/env.sh
#HOS_HOME=`pwd`
#HIVE_DIR=$HOS_HOME/softwares/apache-hive-2.2.0-SNAPSHOT-bin
#SPARK_DIR=$HOS_HOME/softwares/spark-2.0.0-bin-hadoop2-without-hive
#BB_DIR=$HOS_HOME/softwares/BB_HoS
#export SPARK_HOME=$HOS_HOME/softwares/spark-2.0.0-bin-hadoop2-without-hive
#export HIVE_HOME=$HOS_HOME/softwares/apache-hive-2.2.0-SNAPSHOT-bin


# kill metastore
kill_running_server metastore
# kill hive server2
kill_running_server HiveServer2

# remove hive and rearranged
#cd base/
remove_software $HIVE_DIR
software_tar $HOS_HOME/models/apache-hive-2.2.0-SNAPSHOT-bin.tar.gz $HOS_HOME/softwares/
copy_conf $HOS_HOME/conf/hive-site.xml $HIVE_DIR/conf/
copy_conf $HOS_HOME/conf/hive-log4j2.properties $HIVE_DIR/conf/
copy_conf $HOS_HOME/lib/mysql-connector-java.jar $HIVE_DIR/lib/

# remove spark and rearranged
remove_software $SPARK_DIR
software_tar $HOS_HOME/models/spark-2.0.0-bin-hadoop2-without-hive.tar.gz $HOS_HOME/softwares/
copy_conf $HOS_HOME/conf/spark-defaults.conf $SPARK_DIR/conf/

# remove bigBench and rearranged
remove_software $BB_DIR
software_tar $HOS_HOME/models/BB_HoS.tar.gz $HOS_HOME/softwares/
copy_conf $HOS_HOME/conf/engineSettings.conf $BB_DIR/engines/hive/conf/
copy_conf $HOS_HOME/conf/engineSettings.sql $BB_DIR/engines/hive/conf/
copy_conf $HOS_HOME/conf/bigBench.properties $BB_DIR/conf/
copy_conf $HOS_HOME/conf/userSettings.conf $BB_DIR/conf/

echo "" > $HOS_HOME/logs/hive.log
copy_conf $SPARK_HOME/jars/*.jar $HIVE_HOME/lib/
copy_conf $HOS_HOME/lib/mysql-connector-java.jar  $HIVE_HOME/lib/
$HOS_HOME/softwares/apache-hive-2.2.0-SNAPSHOT-bin/bin/hive --service metastore &

