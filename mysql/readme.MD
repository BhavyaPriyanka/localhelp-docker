# MySQL Docker Image in Kubernetes - Complete Guide

# 1. My Docker Image

```dockerfile
FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD=root \
    MYSQL_USER=appuser \
    MYSQL_PASSWORD=localhelp \
    MYSQL_DATABASE=appdb

COPY scripts/*.sql /docker-entrypoint-initdb.d/
```

This image contains:

- MySQL Server (mysqld)
- Docker Entrypoint
- Initialization SQL Scripts
- Default Database
- Default User

It is **NOT** just a filesystem.

It is a complete database server image.

---

# 2. What happens when the container starts?

```
Container Starts
        │
        ▼
docker-entrypoint.sh
        │
        ▼
Checks if /var/lib/mysql is empty
        │
        ├───────────────┐
        │               │
        ▼               ▼
Empty            Already Exists
        │               │
        ▼               ▼
Initialize DB    Skip Initialization
        │
        ▼
Create root user
        │
        ▼
Create appdb
        │
        ▼
Create appuser
        │
        ▼
Execute *.sql
        │
        ▼
Start mysqld
```

Important:

The SQL scripts execute **only once**, during the first initialization.

---

# 3. Why should we NOT use Deployment?

Deployment assumes Pods are disposable.

Database Pods are NOT disposable.

If Pod dies:

Old Pod
↓

New Pod

Without storage:

Database is lost.

Hence Deployment alone is not suitable.

---

# 4. Use StatefulSet

StatefulSet provides

- Stable Pod Name
- Stable Storage
- Ordered Startup
- Ordered Shutdown

Example

mysql-0

Even after restart

mysql-0

Name never changes.

---

# 5. Persistent Volume

Never store MySQL data inside the container.

Wrong

Container
└── /var/lib/mysql

If container dies

Everything is gone.

Correct

Container

↓

PVC

↓

PV

↓

AWS EBS Volume

Now data survives Pod recreation.

---

# 6. Mount the Database

Mount

/var/lib/mysql

to

Persistent Volume

Now

mysqld

writes into EBS instead of container filesystem.

---

# 7. ConfigMaps

Never hardcode

MYSQL_DATABASE

inside Dockerfile.

Instead

ConfigMap

contains

MYSQL_DATABASE=appdb

Pod reads ConfigMap.

Need another environment?

Change ConfigMap only.

Image remains same.

---

# 8. Secrets

Never put

MYSQL_ROOT_PASSWORD=root

inside Dockerfile.

Instead

Secret

contains

MYSQL_ROOT_PASSWORD

MYSQL_PASSWORD

Kubernetes injects them.

Image is reusable.

---

# 9. Services

Applications should never connect to

mysql-0

or

Pod IP.

Instead

ClusterIP Service

Example

mysql.default.svc.cluster.local

Backend connects to Service.

Pods may restart.

Service stays.

---

# 10. Readiness Probe

MySQL needs time to initialize.

Without Readiness Probe

Backend starts

↓

Connects immediately

↓

Connection refused

With Readiness Probe

Backend waits until MySQL is accepting connections.

---

# 11. Liveness Probe

Suppose MySQL hangs.

Container still running.

But database isn't responding.

Liveness Probe

↓

Kills Container

↓

Kubernetes starts a fresh container.

---

# 12. Resource Limits

Example

CPU Request

500m

Memory Request

1Gi

Memory Limit

2Gi

Prevents MySQL from consuming entire node memory.

---

# 13. Security Context

Never run production database as privileged.

Use

runAsNonRoot

ReadOnlyRootFilesystem

Drop Linux Capabilities

---

# 14. Image Pull Policy

Development

IfNotPresent

Production

Specific Version

Example

sbp828/mysql:v1.0

Never

latest

---

# 15. Versioning

Good

v1.0

v1.1

v1.2

Bad

latest

Rollback becomes impossible.

---

# 16. Health Verification

Useful Commands

docker ps

docker logs mysql

docker exec -it mysql bash

mysql -uroot -p

SHOW DATABASES;

SHOW TABLES;

---

# 17. Production Storage

AWS

PVC

↓

StorageClass

↓

EBS CSI Driver

↓

EBS Volume

If Pod moves

EBS attaches

Data survives.

---

# 18. Backup Strategy

Never rely on Docker Image.

Backups should be taken from

Persistent Volume

or

mysqldump

Typical methods

CronJob

AWS Backup

Velero

Snapshot

---

# 19. Monitoring

Monitor

Connections

Buffer Pool

Queries/sec

Slow Queries

CPU

Memory

Disk

Prometheus + mysqld-exporter

---

# 20. Logging

Do not SSH into Pods.

Collect logs using

Fluent Bit

Loki

EFK

---

# 21. Real Production Flow

Developer

↓

Build Image

↓

Docker Hub / ECR

↓

StatefulSet

↓

PVC

↓

PV

↓

AWS EBS

↓

ClusterIP Service

↓

Spring Boot Backend

↓

Users

---

# 22. Things NOT to put inside Docker Image

❌ Passwords

❌ Secrets

❌ Production Database

❌ Backup Files

❌ Environment Specific Config

❌ SSL Certificates

❌ Large Log Files

---

# 23. Things that SHOULD be inside Docker Image

✅ MySQL Server

✅ Initialization Scripts

✅ Default Schema

✅ Default User Creation Logic

✅ Required Plugins

✅ Custom Configuration

---

# 24. Production Checklist

✔ Versioned Image

✔ StatefulSet

✔ Persistent Volume

✔ StorageClass

✔ Secret

✔ ConfigMap

✔ ClusterIP Service

✔ Readiness Probe

✔ Liveness Probe

✔ Resource Limits

✔ Security Context

✔ Monitoring

✔ Logging

✔ Backup

✔ Recovery Plan
