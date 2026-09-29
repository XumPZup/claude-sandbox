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
RUN mkdir -p /home/claude/.claude \
    && chown -R claude:claude /home/claude

USER claude

ENV HOME=/home/claude

# Install Claude Code
RUN curl -fsSL https://claude.ai/install.sh | bash

RUN echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/claude/.bashrc
RUN echo 'export CLAUDE_CONFIG_DIR="/home/claude/.config/claude-code"' >> /home/claude/.bashrc

WORKDIR /workspace

#ENTRYPOINT ["claude"]
