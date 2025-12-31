# API to MySQL Data Ingestion – Containerized Jupyter Prototype

## Overview

This repository provides a **portable, containerized prototype** for ingesting data from an external API into a MySQL database using **Python and Jupyter Notebooks**. It is designed to demonstrate an industry-style data ingestion pattern that is easy to understand, extend, and migrate across environments.

The project intentionally focuses on clarity, reproducibility, and good data-engineering practices rather than production orchestration. It is well suited for:

* Prototyping API ingestion pipelines
* Demonstrating ingestion patterns to stakeholders or teams
* Local experimentation before moving to Airflow, dbt, or managed platforms
* Interview, portfolio, or proof-of-concept use cases

---

## What This Project Does

At a high level, this project:

1. Runs a **Jupyter Notebook environment** inside a Docker container
2. Connects to an **external REST API**
3. Fetches and normalizes JSON data from the API
4. Applies basic data quality checks
5. Loads the data into a **MySQL database** using an idempotent (upsert) pattern
6. Uses **Docker Compose** so the entire stack can be started with a single command

Everything (Notebook, Python dependencies, and database) runs in containers, making the setup fully reproducible and easy to migrate.

---

## Architecture

```
External API
     │
     ▼
Jupyter Notebook (Python)
     │
     ▼
MySQL Database
```

**Key design principles:**

* Clear separation between ingestion logic and infrastructure
* Environment configuration via environment variables
* Retry and failure handling for API calls
* Idempotent database writes (safe re-runs)

---

## Technology Stack

* **Python 3.11** – ingestion logic
* **Jupyter Notebook** – interactive development and prototyping
* **Requests** – API communication
* **Pandas** – data normalization and validation
* **SQLAlchemy + PyMySQL** – database connectivity and upserts
* **MySQL 8** – target database
* **Docker & Docker Compose** – containerization and portability

---

## Repository Structure

```
api-to-mysql-notebook/
├── docker-compose.yml      # Orchestrates Jupyter + MySQL
├── Dockerfile              # Jupyter Notebook image
├── requirements.txt        # Python dependencies
├── .env.example            # Environment variable template
├── notebooks/
│   └── api_to_mysql.ipynb  # Main ingestion notebook
└── README.md
```

---

## Getting Started

### Prerequisites

* Docker
* Docker Compose

No local Python or MySQL installation is required.

---

### Setup

1. Clone the repository:

```bash
git clone <repo-url>
cd api-to-mysql-notebook
```

2. Create an environment file:

```bash
cp .env.example .env
```

3. Update `.env` with your settings:

```env
# MySQL
MYSQL_DATABASE=demo
MYSQL_USER=demo_user
MYSQL_PASSWORD=demo_pass
MYSQL_ROOT_PASSWORD=root_pass

# API
API_BASE_URL=https://jsonplaceholder.typicode.com
API_TOKEN=
```

> The default API uses `jsonplaceholder.typicode.com` (no authentication). Replace this with your real API as needed.

---

### Start the Stack

```bash
docker compose --env-file .env up --build
```

This will:

* Start a MySQL container
* Start a Jupyter Notebook container
* Automatically connect the notebook to the database

Once running, Jupyter will output a URL with an access token in the logs:

```
http://localhost:8888/?token=...
```

---

## Using the Notebook

Open `notebooks/api_to_mysql.ipynb` and follow the cells in order.

The notebook walks through:

1. Loading configuration from environment variables
2. Connecting to MySQL
3. Calling the API with retries and error handling
4. Normalizing JSON responses into a Pandas DataFrame
5. Applying basic data quality checks
6. Creating the target table if it does not exist
7. Loading data using an **upsert** pattern
8. Verifying the loaded data

Each step is intentionally explicit to make the ingestion logic easy to follow and adapt.

---

## Design Decisions

### Why Jupyter?

* Fast iteration and visibility into data
* Easy to explain and demo ingestion logic
* Ideal for prototyping and exploration before automation

### Why Containers?

* Fully reproducible environment
* Easy migration between laptops, servers, or cloud VMs
* No dependency conflicts
* Clear separation of infrastructure and logic

### Why Upserts?

* Pipelines can be safely re-run
* Prevents duplicate records
* Aligns with industry best practices for API ingestion

---

## How to Extend This

This prototype is intentionally simple but extensible. Common next steps include:

* Adding pagination (cursor or page-based)
* Handling incremental loads using timestamps or watermarks
* Adding structured logging
* Writing ingestion configuration to YAML instead of code
* Scheduling via Airflow, Prefect, or cron
* Replacing MySQL with Postgres, Snowflake, or BigQuery

---

## Intended Audience

This repository is useful for:

* Data Engineers prototyping ingestion pipelines
* Teams evaluating ingestion approaches
* Interview or portfolio demonstrations
* Teaching or knowledge-sharing sessions

---

## Disclaimer

This project is a **prototype**, not a full production system. It focuses on illustrating ingestion concepts and patterns rather than enterprise-scale orchestration, security hardening, or performance tuning.

---

## License

MIT License (or update as appropriate)
api-to-mysql-notebook/
├─ docker-compose.yml
├─ Dockerfile
├─ requirements.txt
├─ .env.example
└─ notebooks/
   └─ api_to_mysql.ipynb  (you will create this from the code below)
