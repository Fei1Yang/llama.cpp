ARG UBUNTU_VERSION=22.04

FROM ubuntu:$UBUNTU_VERSION as build

RUN apt-get update && \
    apt-get install -y build-essential python3 python3-pip git

COPY requirements.txt requirements.txt

RUN pip install --upgrade pip setuptools wheel \
    && pip install -r requirements.txt

WORKDIR /app

COPY . .

RUN LLAMA_AVX2_ONLY=1 make

ENV LC_ALL=C.utf8

ENTRYPOINT ["/app/.devops/tools.sh"]
