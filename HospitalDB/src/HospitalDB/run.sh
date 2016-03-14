#!/bin/sh
export CLASSPATH=$CLASSPATH:/usr/share/java/postgresql.jar
psql -h pgsql2.mif studentu -f createAllDB.sql
javac Main.java UI.java SQLDB.java
java Main
psql -h pgsql2.mif studentu -f deleteAll.sql
