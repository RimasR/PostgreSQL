javac -d classes -cp classes src/HospitalDB/Main.java src/HospitalDB/ui/UI.java src/HospitalDB/sql/SQLDB.java
java -cp classes;lib/postgresql-9.2-1002.jdbc4.jar Main.java
