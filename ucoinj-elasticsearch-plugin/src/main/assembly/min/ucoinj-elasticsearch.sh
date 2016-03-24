#!/bin/bash

REP=$(dirname $0)
cd $REP

#Comment out this line to specify your JAVA path:
export JAVA_HOME=/usr/lib/jvm/default-java

export APP_BASEDIR=$REP
export JAVA_COMMAND=$JAVA_HOME/bin/java
export APP_LOG_FILE=$APP_BASEDIR/logs/${project.artifactId}-${project.version}.log
export APP_CONF_FILE=$APP_BASEDIR/ucoinj.config

cd $APP_BASEDIR

if [ -d $JAVA_HOME ]; then
	echo "${project.name}"
	echo "  basedir:  $APP_BASEDIR"
	echo "  jre home: $JAVA_HOME"
	echo "  log file: $APP_LOG_FILE"
	
	MEMORY="-Xmx1G"
	#APP_JVM_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=8000"
	
	echo "launch java"
	echo "java command: $JAVA_COMMAND"
	
	$JAVA_COMMAND $MEMORY $APP_JVM_OPTS -Ducoinj.basedir=$APP_BASEDIR -Ducoinj.plugins.directory=$APP_BASEDIR/plugins -Ducoinj.log.file=$APP_LOG_FILE -Ducoinj-elasticsearch.config=$APP_CONF_FILE -Ducoinj.launch.mode=full -Djna.nosys=true -Des.http.cors.allow-origin=* -jar ucoinj-elasticsearch-plugin-${project.version}.jar $*

	exitcode=$?
	echo "Stop ${project.name} with exitcode: $exitcode"
	exit $exitcode
	
else
	echo "Java not detected ! Please set environment variable JAVA_HOME before launching,"
	echo "or edit the file 'launch.sh' and insert this line :"
	echo "                                                     export JAVA_HOME=<path_to_java>"
fi
