FROM ubuntu:18.04
RUN apt-get update
RUN apt install git -y
RUN apt install tomcat9 -y
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
FROM maven:3.6-jdk-11 as build
WORKDIR /boxfuse-sample-java-war-hello
COPY src .
COPY pom.xml .
RUN mvn -f /boxfuse-sample-java-war-hello/pom.xml clean package && rm -r target/
FROM openjdk:11.0-jre
WORKDIR /boxfuse-sample-java-war-hello
COPY --from=build /boxfuse-sample-java-war-hello/target/hello-1.0.war /var/lib/tomcat9/webapps/hello-1.0.war
EXPOSE 8080
CMD ["catalina.sh", "run"]