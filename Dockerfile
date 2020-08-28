FROM python:3.8-slim-buster
LABEL maintainer="artflag"

RUN apt-get update && apt-get install -y \
    curl \
    make && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir pipenv

WORKDIR /sphinxtechnicalwriting

COPY Pipfile Pipfile.lock /sphinxtechnicalwriting/

RUN pipenv install --system --deploy
