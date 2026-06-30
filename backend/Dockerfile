FROM maven:3.9.9-eclipse-temurin-21

RUN useradd -m localhelp

WORKDIR /app

RUN chown localhelp:localhelp /app

COPY --chown=localhelp:localhelp pom.xml .
COPY --chown=localhelp:localhelp src ./src

USER localhelp

ENV DB_HOST=mysql

RUN mvn clean package -DskipTests

EXPOSE 8080

ENTRYPOINT ["sh", "-c", "java -jar target/*.jar"]