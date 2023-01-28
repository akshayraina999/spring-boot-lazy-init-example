FROM maven:3.8.5-openjdk-11 AS maven_build

COPY pom.xml /tmp/

COPY src /tmp/src/

WORKDIR /tmp/

RUN mvn clean install

FROM eclipse-temurin:11

EXPOSE 8080

COPY --from=maven_build /tmp/target/spring-boot-lazy-init-example-0.0.1-SNAPSHOT.jar /data/spring-boot-lazy-init-example-0.0.1-SNAPSHOT.jar

CMD java -jar /data/spring-boot-lazy-init-example-0.0.1-SNAPSHOT.jar