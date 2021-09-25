FROM ubuntu:18.04
RUN apt-get update
RUN apt install git -y
WORKDIR /tmp/
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
FROM maven:3.6-adoptopenjdk-11 AS build
COPY /home/svetlershova/pythonProject2/boxfuse-sample-java-war-hello/pom.xml /tmp/
COPY /home/svetlershova/pythonProject2/boxfuse-sample-java-war-hello/src /tmp/
WORKDIR /tmp/
RUN mvn clean package
FROM tomcat:9.0-jre11-openjdk
COPY --from=build /tmp/target/hello-1.0.war /var/lib/tomcat9/webapps/hello-1.0.war
EXPOSE 8080
CMD ["catalina.sh", "run"]