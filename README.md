# 🐳 LocalHelp Docker

Docker configuration for the **LocalHelp** application.

This repository contains the Dockerfiles and Docker Compose configuration used to build and run the LocalHelp application in a containerized environment.


This Dockerfile does the following in order:

1. **Creates a build environment** using Maven and Java 21 for the LocalHelp backend.

2. **Sets `/build` as the working directory** inside the build container.

3. **Copies `pom.xml`** into the build container.

4. **Downloads all Maven dependencies** using `mvn dependency:go-offline`.

5. **Copies the LocalHelp backend source code** into the build container.

6. **Builds the application** using Maven and generates the Spring Boot JAR file.

7. **Creates a separate lightweight runtime environment** using Distroless Java 21.

8. **Runs the application as a non-root user** for better security.

9. **Copies only the generated JAR** from the build stage into the runtime image.

10. **Exposes port 8080** for the LocalHelp backend application.

11. **Starts the LocalHelp backend** using `java -jar app.jar`.

12. **Final result:** a lightweight production-ready Docker image containing only the LocalHelp backend application and the Java runtime needed to run it.


## Tech Stack

- Docker
- Docker Compose

## Repository Structure

```
.
├── backend/
├── frontend/
├── mysql/
├── docker-compose.yml
└── README.md
```

## Getting Started

Build the images:

```bash
docker compose build
```

Start the application:

```bash
docker compose up -d
```

Stop the application:

```bash
docker compose down
```

## Related Repositories

- `localhelp-backend`
- `localhelp-frontend`
- `localhelp-infra-terraform`
- `localhelp-ansible-roles`

---

**Part of the LocalHelp DevOps project.**
