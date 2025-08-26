FROM python:3.9-slim

# ติดตั้ง dependency ที่จำเป็น
WORKDIR /app
COPY requirements.txt .
RUN python -m pip install --upgrade pip \
    && python -m pip install -r requirements.txt

# copy app เข้าไป
COPY app.py .

CMD ["python", "app.py"]
