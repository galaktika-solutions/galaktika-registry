FROM python:3.6.6-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
  jq \
  curl

RUN pip install --upgrade pip
RUN pip install --no-cache-dir \
      periodtask==0.5.4

COPY registry.sh /registry.sh
