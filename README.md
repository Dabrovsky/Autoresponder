# Autoresponder

A Rails REST API application that integrates with OpenAI to provide automated responses for tickets.

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [Clone the Repository](#clone-the-repository)
  - [Environment Setup](#environment-setup)
  - [Run Locally](#run-locally)
    - [Set Up Cron Jobs](#set-up-cron-jobs) (not necessary when using Docker)
  - [Run with Docker](#run-with-docker) (preferred)
- [API Documentation](#api-documentation)

---

## Prerequisites

Make sure you have the following installed before setting up the app:

- Ruby **3.4.2**
- Rails **8.0.2**
- PostgreSQL
- Docker (optional)

---

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/Dabrovsky/Autoresponder.git
cd Autoresponder
```

### Environment Setup

Before running the app, configure your OpenAI API key by creating an environment file:

```bash
touch .env.development
```

Inside `.env.development`:

```
OPENAI_API_KEY=your_api_key_here
```

---

### Run Locally

1. Install dependencies:

   ```bash
   bundle install
   ```

2. Prepare the database:

   ```bash
   rails db:create
   rails db:migrate
   ```

3. Start the server:

   ```bash
   rails s
   ```

4. Run tests:

   ```bash
   rspec
   ```

---

### Set Up Cron Jobs

The application relies on background tasks managed via the [whenever](https://github.com/javan/whenever) gem.
Before running the app locally, make sure to update and start the cron jobs:

```bash
whenever --update-crontab
```

Verify that the cron jobs are installed:

```bash
crontab -l
```

---

### Run with Docker

1. Build and start the container:

   ```bash
   docker compose up -d --build
   ```

2. Prepare the database:

   ```bash
   docker compose exec app rails db:create
   docker compose exec app rails db:migrate
   ```

3. Run tests:

   ```bash
   docker compose exec app rspec
   ```

4. Access the container shell (optional):

   ```bash
   docker compose exec app sh
   ```

5. Stop the container:

   ```bash
   docker compose down
   ```

---

## Access

By default, the application is available at:
👉 [http://localhost:3000](http://localhost:3000)

## API Documentation

Below are examples of available API endpoints.
Replace the base URL with your environment (e.g., http://localhost:3000).

### List Tickets

Endpoint

```bash
  GET /api/v1/tickets
```

Response

```json
  {
    "data": [
      {
        "id": "cf6cb78d-4c84-4186-8732-98affe4ca04d",
        "type": "ticket",
        "attributes": {
          "status": "pending",
          "customer_email": "johndoe@example.com",
          "message": "Ticket description",
          "created_at": "2025-08-18 19:58:57 UTC",
          "updated_at": "2025-08-18 19:59:13 UTC"
        }
      }
    ]
  }
```

### List Answers for a Ticket

Endpoint

```bash
  GET /api/v1/tickets/:ticket_id/answers
```

Response

```json
  {
    "data": [
      {
        "id": "4f00fbda-cc3a-45a1-bb07-55ef8f0dadab",
        "type": "answer",
        "attributes": {
          "status": "pending",
          "message": "Answer message",
          "rejected_reason": null,
          "created_at": "2025-08-18 19:58:57 UTC",
          "updated_at": "2025-08-18 19:59:13 UTC"
        }
      }
    ]
  }
```

### Accept Answer

Endpoint

```bash
  POST /api/v1/tickets/:ticket_id/answers/:id/accept
```

Request body

```json
  {
    "answer": {}
  }
```

Response

```json
  {
    "data": [
      {
        "id": "4f00fbda-cc3a-45a1-bb07-55ef8f0dadab",
        "type": "answer",
        "attributes": {
          "status": "accepted",
          "message": "Answer message",
          "rejected_reason": null,
          "created_at": "2025-08-18 19:58:57 UTC",
          "updated_at": "2025-08-18 19:59:13 UTC"
        }
      }
    ]
  }
```

### Reject Answer

Endpoint

```bash
  POST /api/v1/tickets/:ticket_id/answers/:id/reject
```

Request body

```json
  {
    "answer": {
      "rejected_reason": "Some additional information to be included in the answer."
    }
  }
```

Response

```json
  {
    "data": [
      {
        "id": "4f00fbda-cc3a-45a1-bb07-55ef8f0dadab",
        "type": "answer",
        "attributes": {
          "status": "rejected",
          "message": "Answer message",
          "rejected_reason": "Some additional information to be included in the answer.",
          "created_at": "2025-08-18 19:58:57 UTC",
          "updated_at": "2025-08-18 19:59:13 UTC"
        }
      }
    ]
  }
```

### Other available endpoints

Create Ticket

```bash
  POST /api/v1/tickets/
```

```json
  {
    "ticket": {
      "customer_email": "johndoe@example.com",
      "message": "Message"
    }
  }
```

Update Ticket

```bash
  PATCH /api/v1/tickets/:id
```

```json
  {
    "ticket": {
      "customer_email": "johndoe@example.com",
      "message": "Message"
    }
  }
```

Destroy Ticket

```bash
  DELETE /api/v1/tickets/:id
```
