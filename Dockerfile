FROM openjdk:11.0.11-jdk-oracle
ENV TZ=Asia/Kolkata
WORKDIR /app
COPY ./target/my-project-0.0.1-SNAPSHOT.jar .
EXPOSE 8080
ENTRYPOINT [ "java", "--jar", "my-project-0.0.1-SNAPSHOT.jar"]



