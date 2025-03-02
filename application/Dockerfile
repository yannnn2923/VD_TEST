FROM registry-docker.apps.eul.sncf.fr/hub-cicd-external/library/alpine

ENV PG_HOST db
ENV PG_PASSWORD motdepasse

RUN apk update && apk add py3-gunicorn py3-flask py3-psycopg libpq py3-faker
COPY ./application/app.py app.py

ENTRYPOINT gunicorn app:app -b :8000
