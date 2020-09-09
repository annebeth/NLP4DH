import os, time, json

import redis
from rq import Queue

import psycopg2

from annotations import annotate

redis_url = os.getenv('REDIS_URL', 'redis://localhost:6379')
postgres_url = os.getenv('DATABASE_URL', 'dbname=nlp4dh_development user=postgres')

conn = psycopg2.connect(postgres_url)
r = redis.from_url(redis_url)

# RQ is used so that we have access to the queue + methods.
queue = Queue('annotate', connection=r)

if __name__ == '__main__':
    with r and conn:

        while True:
            # RQ expects this to be just ids, but we get a full message from Resque.
            c = conn.cursor()
            for job_ref in queue.job_ids:
                job = eval(job_ref)
                print(job)

                if "class" in job and job["class"] == "Annotator":
                    text_document_id = job["args"][0]

                    try:
                        c.execute('''SELECT file_content FROM text_documents
                                    WHERE text_documents.id = %s;''', (text_document_id,))
                        file_content = c.fetchone()[0]
                    except:
                        print("Job id not present in db. Could not be processed.")
                        # Remove the job from the queue if it is no longer in db.
                        queue.remove(job_ref)
                        break

                    annotation = annotate(file_content, text_document_id)

                    annotation_json = json.dumps(annotation, indent=4)

                    c.execute('''UPDATE text_documents
                                SET annotation = %s
                                WHERE text_documents.id = %s;''',
                                (annotation_json, text_document_id,))
                    conn.commit()

                    # Remove the job from the queue when done.
                    queue.remove(job_ref)

            c.close()

            time.sleep(2)

conn.close()
