FROM python:3.12.5-bullseye

ENV DEBIAN_FRONTEND=noninteractive \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR='/var/cache/pypoetry' \
    POETRY_HOME='/usr/local' \
    POETRY_VERSION=1.8.4 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Basic development tools
RUN apt-get update && apt-get install -y \
    && apt-get clean 

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -


# Create unprivileged user
RUN useradd \
    --create-home \
    --shell /bin/bash \
    claude

# Workspace
RUN mkdir -p /workspace \
    && chown claude:claude /workspace


# Claude configuration directory
RUN mkdir -p /home/claude/.claude 

# Copy entrypoint
COPY entrypoint.sh /home/claude/
RUN chmod +x /home/claude/entrypoint.sh

RUN chown -R claude:claude /home/claude

USER claude

ENV HOME=/home/claude

# Install Claude Code
RUN curl -fsSL https://claude.ai/install.sh | bash

ENV HOME=/home/claude \
    PATH=/home/claude/.local/bin:$PATH \
    CLAUDE_CONFIG_DIR=/home/claude/.config/claude-code

WORKDIR /workspace

ENTRYPOINT ["/home/claude/entrypoint.sh"]
