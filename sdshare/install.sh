# Installs the jar as a Maven artifact
mvn install:install-file -Dfile=build/jars/sdshare.jar -DgroupId=net.ontopia -DartifactId=ontopia-sdshare -Dversion=1.0-SNAPSHOT -Dpackaging=jar