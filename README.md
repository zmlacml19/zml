This is the project to deploy Hive Spark and Pig automatically onto Hadoop cluster.

Goal
1. Redeploy cluster with new patch for supported services(Pig, Spark, Hive and Hadoop if needed). 
2. Switch Spark version(update ENVs and needed services)

Requirements
1. Keep old configurations when redeploying
2. Replace Yarn related configurations if updating configurations like External.shuffle.services
