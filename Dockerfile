FROM python:3.9

WORKDIR /app

COPY server.py client.py ./

CMD ["python", "server.py"]
