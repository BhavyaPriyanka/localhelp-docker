# 🐳 LocalHelp Docker

Docker configuration for the **LocalHelp** application.

This repository contains the Dockerfiles and Docker Compose configuration used to build and run the LocalHelp application in a containerized environment.

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
