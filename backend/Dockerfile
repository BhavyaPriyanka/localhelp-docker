FROM maven:3.9.9-eclipse-temurin-21

RUN useradd -m localhelp

WORKDIR /app

COPY --chown=localhelp:localhelp pom.xml .
COPY --chown=localhelp:localhelp src ./src

USER localhelp

ENV DB_HOST=mysql

RUN whoami
RUN id
RUN pwd
RUN ls -ld /app
RUN ls -la /app
RUN mkdir -p /app/target
RUN ls -ld /app/target
RUN touch /app/target/testfile

RUN mvn clean package -DskipTests

EXPOSE 8080

ENTRYPOINT ["sh", "-c", "java -jar target/*.jar"]