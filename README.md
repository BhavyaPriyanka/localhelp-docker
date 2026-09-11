# 🐳 LocalHelp Docker

Docker configuration for the **LocalHelp application**.

This repository contains the Dockerfiles and Docker Compose configuration required to build and run the LocalHelp application in a containerized environment.

---

## 🐳 Dockerfile Build Flow

The backend Dockerfile performs the following steps in order:

1. **Creates the build environment**
   - Uses Maven with Java 21 to build the LocalHelp backend.

2. **Sets the working directory**
   - Uses `/build` as the working directory inside the build container.

3. **Copies the Maven configuration**
   - Copies `pom.xml` into the build container.

4. **Downloads Maven dependencies**
   - Runs `mvn dependency:go-offline` to download dependencies in advance.
   - This also allows Docker to cache the dependency layer and speed up subsequent builds.

5. **Copies the application source code**
   - Copies the `src` directory into the build container.

6. **Builds the application**
   - Runs Maven to compile and package the application.
   - Generates the Spring Boot JAR file.

7. **Creates the runtime environment**
   - Uses a lightweight Distroless Java 21 image for running the application.

8. **Runs as a non-root user**
   - Uses the Distroless `nonroot` image to improve container security.

9. **Copies only the application JAR**
   - Copies the generated JAR from the build stage into the runtime image.
   - Maven, source code, and build dependencies are not included in the final image.

10. **Exposes the application port**
    - Exposes port `8080`, where the Spring Boot backend listens.

11. **Starts the application**
    - Runs the application using `java -jar app.jar`.

12. **Final result**
    - Produces a lightweight and secure runtime image containing only the Java runtime and LocalHelp backend application.

---

## 🛠️ Tech Stack

- Docker
- Docker Compose
- Maven
- Java 21
- Spring Boot
- Distroless Java

---

## 📁 Repository Structure

```text
.
├── backend/
├── frontend/
├── mysql/
├── docker-compose.yml
└── README.md
