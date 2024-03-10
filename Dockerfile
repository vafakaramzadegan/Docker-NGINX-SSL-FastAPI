FROM python:3.11-slim

WORKDIR /app

COPY Pipfile Pipfile.lock ./

# install Pipenv and Python dependencies
RUN pip install --no-cache-dir pipenv
RUN pipenv install --deploy --ignore-pipfile

COPY ./app .

CMD ["pipenv", "run", "gunicorn", "-w", "4", "-k", "uvicorn.workers.UvicornWorker", "main:app", "-b", "0.0.0.0:8000"]