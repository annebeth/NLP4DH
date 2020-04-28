import os, time

from redis import Redis
from rq import Queue

import psycopg2

# Check whether a REDIS_URL is defined in the environment.
if os.environ.get("REDIS_URL"):
    redis_url = os.environ.get("REDIS_URL")
    conn = psycopg2.connect("dbname=nlp4dh_production user=postgres")
else:
    redis_url = "localhost"
    conn = psycopg2.connect("dbname=nlp4dh_development user=postgres")

# r = redis.from_url(redis_url)
redis = Redis(redis_url)
# RQ is used so that we have access to the queue + methods.
queue = Queue('annotate', connection=redis)

if __name__ == '__main__':
    with redis and conn:

        # RQ expects this to be just ids, but we get a full message from Resque.
        c = conn.cursor()
        for job_ref in queue.job_ids:
            job = eval(job_ref)

            if "class" in job and job["class"] == "Annotator":
                text_document_id = job["args"][0]

                c.execute('''UPDATE text_documents
                            SET description = 'HA! Got you! :D'
                            WHERE text_documents.id = %s;''', (text_document_id,))
                conn.commit()

                # Remove the job from the queue when done.
                queue.remove(job_ref)

        c.close()

        time.sleep(10)

conn.close()

# # To empty the entire queue
# queue.empty()
