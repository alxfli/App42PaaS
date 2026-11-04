# App42PaaS Java MySQL Sample (Dockerized)

## Features

**Multi-stage Docker build:**  
Automatically compiles the legacy Maven project inside the container.

**Environment Variables:**  
All sensitive data (passwords, database names) is securely managed via `.env` files.

**Automatic Configuration:**  
The application's `Config.properties` is generated at runtime based on environment variables.

**Healthchecks:**  
Ensures the application only starts after the MySQL database is fully ready.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Quick Start

1. Clone the repository:
   
        git clone https://github.com/alxfli/App42PaaS.git
    
        cd App42PaaS

2. Set up the environment variables

        cp .env.example .env

3. **Edit .env and set a strong DB_PASSWORD**

4. Build and run the containers

        docker compose up --build -d

5. Access the application

        http://localhost