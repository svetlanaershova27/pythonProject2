FROM ubuntu:18.04
RUN apt-get update
RUN apt install git -y
RUN apt install default-jdk -y
RUN apt install tomcat9 -y
RUN apt install maven -y
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
FROM maven AS build
COPY src /boxfuse-sample-java-war-hello/src
COPY pom.xml /boxfuse-sample-java-war-hello/
RUN mvn -f /boxfuse-sample-java-war-hello/pom.xml clean package
COPY --from=build /boxfuse-sample-java-war-hello/target/hello-1.0.war /var/lib/tomcat9/webapps/hello-1.0.war
EXPOSE 8080
CMD ["catalina.sh", "run"]