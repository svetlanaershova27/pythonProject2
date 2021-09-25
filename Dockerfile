FROM ubuntu:18.04
RUN apt-get update
RUN apt install git -y
WORKDIR /tmp/
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
FROM maven:3.6-adoptopenjdk-11 AS build
COPY pom.xml /tmp/boxfuse-sample-java-war-hello/
COPY src /tmp/boxfuse-sample-java-war-hello/src/
WORKDIR /tmp/boxfuse-sample-java-war-hello/
RUN mvn clean package
FROM tomcat:9.0-jre11-openjdk
COPY --from=build /tmp/boxfuse-sample-java-war-hello/target/hello-1.0.war /var/lib/tomcat9/webapps/hello-1.0.war
EXPOSE 8080
CMD ["catalina.sh", "run"]