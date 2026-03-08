# Scrapyd Docker for UnRaid

This repository contains a Docker setup for running **Scrapyd** with persistent configuration and auto-reload for your Scrapy spiders. It is designed to be used on UnRaid but can work on any Docker environment.

## Features

- Scrapyd server running inside Docker.
- Auto-copy of initial image configuration to `appdata` on first run.
- Persistent storage for projects, logs, and databases.
- Auto-reload of spiders without re-deploying.
- Compatible with UnRaid templates and custom icons.

## Folder Structure

```text
scrapyd-docker/
├── app/                # Runtime folder inside container
├── app-image/          # Read-only copy of default configuration files
├── scripts/            # Entrypoint and helper scripts
│   └── entrypoint.sh
├── .env                # For now is just used for the icon
├── scrapy.cfg          # Main Scrapy configuration
├── scrapyd.png         # Scrapyd icon for UnRaid
├── Dockerfile
├── docker-compose.yml
├── requirements.txt
└── README.md
```

## Getting Started

1. Clone this repository:
    ```bash
    git clone https://github.com/yourusername/scrapyd-docker.git
    cd scrapyd-docker
    ```

2. Set your `.env` variables (if needed):
    ```
    ICON_PATH="/mnt/user/appdata/scrapyd/icons/scrapyd.png"
    ```

3. Launch the container:
    ```bash
    docker compose up -d
    ```

4. Check/Accesss Scrapyd:

    Open your browser at `http://<your-unraid-ip>:6800`.

5. Deploy your spiders:

    Copy your Scrapy spiders into ``appdata/scrapyd/scraper`` or use ``curl`` to schedule them.

    ```bash
    curl http://<scrapyd-ip>:6800/schedule.json -d project=myproject -d spider=myspider
    ```

## Updating Configuration
- All configuration files are persisted in appdata/scrapyd.
- If a new file is added to the image in future versions, the entrypoint script will copy it to appdata automatically.