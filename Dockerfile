FROM ubuntu:18.04
RUN apt-get update
RUN apt install git -y
RUN apt install default-jdk -y
RUN apt install tomcat9 -y
RUN apt install maven -y
RUN cd /home/
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
RUN mvn package boxfuse-sample-java-war-hello/
RUN cp  boxfuse-sample-java-war-hello/target/hello-1.0.war /var/lib/tomcat9/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]