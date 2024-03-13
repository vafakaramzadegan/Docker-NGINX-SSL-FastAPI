FROM python:3.11-slim

# Create a new user
RUN useradd -m myuser

WORKDIR /app
RUN chown -R myuser:myuser /app

USER myuser

# Set PATH to include user binaries
ENV PATH="/home/myuser/.local/bin:${PATH}"

RUN pip install --no-cache-dir pipenv

COPY --chown=myuser:myuser Pipfile Pipfile.lock ./

RUN pipenv install --deploy --ignore-pipfile

COPY --chown=myuser:myuser ./app .

CMD ["pipenv", "run", "gunicorn", "-w", "4", "-k", "uvicorn.workers.UvicornWorker", "main:app", "-b", "0.0.0.0:8000"]
