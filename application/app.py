from flask import Flask, abort
import psycopg
import os
from faker import Faker

pg_host = os.environ['POSTGRES_HOST']
pg_password = os.environ['POSTGRES_PASSWORD']
pg_dbname = os.environ['POSTGRES_DB']
pg_dbuser = os.environ['POSTGRES_USER']
pg_dbport = os.environ['POSTGRES_PORT']
url_prefix = os.environ['URL_PREFIX']
app = Flask(__name__)
app.logger.warning('debut')
fake = Faker()

app.logger.warning('Avant connexion')
with psycopg.connect(f"host={pg_host} port={pg_dbport} dbname={pg_dbname} user={pg_dbuser} password={pg_password}") as conn:
    with conn.cursor() as cur:
        try:
            cur.execute("""
                CREATE TABLE pouletfrit (
                    id serial PRIMARY KEY,
                    value text
                )
            """)
        except psycopg.errors.DuplicateTable:
            app.logger.warning("La table semble déjà existée.")
            conn.rollback()
        cur.executemany(
            """
            INSERT INTO pouletfrit (value)
            VALUES (%s)
            """,
            [(fake.name(),) for _ in range(5)]
        )
app.logger.warning('Apres Connexion')
app.logger.warning(f"Le prefix est {url_prefix}")


@app.route("/")
def main():
    app.logger.warning('Requete principale')
    result = {}
    result['request_status'] = 'OK!'
    result['values'] = []
    with psycopg.connect(f"host={pg_host} port={pg_dbport} dbname={pg_dbname} user={pg_dbuser} password={pg_password}") as conn:
        with conn.cursor() as cur:
            cur.execute("select value from pouletfrit")
            for record in cur.fetchall():
                result['values'].append(record[0])
    return result


@app.route("/error")
def error():
    app.logger.error("Erreur lors d'une requête")
    abort(503)


@app.route("/healthcheck")
def healthcheck():
    return {"status": "OK"}
