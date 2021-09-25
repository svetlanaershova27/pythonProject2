FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install git -y
RUN apt-get install default-jdk -y
RUN apt-get install tomcat9 -y
RUN apt-get install maven -y
RUN cd /home/tmp
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
RUN cd boxfuse-sample-java-war-hello/
RUN mvn package
RUN  cp hello-1.0.war /var/lib/tomcat9/webapps/
RUN http://  :8080/hello-1.0/
EXPOSE 8080
CMD ["catalina.sh", "run"]