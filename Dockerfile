FROM python:3.9-buster

WORKDIR /app
COPY requirements.txt .
RUN python3 -m pip install --upgrade pip \
    && python3 -m pip install -r requirements.txt
COPY app.py .

CMD ["python3", "app.py"]
