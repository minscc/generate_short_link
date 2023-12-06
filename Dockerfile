FROM --platform=linux/arm64 python:3.11


WORKDIR /app

# Install Poetry
RUN apt update -q && apt install git -qy && \
    python -m pip install --upgrade pip && \
    python -m pip install setuptools && \
    python -m pip install poetry && \
    poetry config virtualenvs.create false


COPY ./poetry.lock /app/
COPY ./pyproject.toml /app/

RUN pip install pydantic[dotenv] uvicorn[standard] gunicorn

RUN rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY ./src /app/src/
COPY ./app.py /app/main.py

COPY ./.env.test /app/
COPY ./start_server.sh /app/start_server.sh

RUN chmod +x start_server.sh