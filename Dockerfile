FROM ubuntu:20.04
RUN apt-get update && apt-get install -y python3 python3-pip && pip3 install flask
COPY app.py /app/
ENV FLASK_APP=/app/app.py
ENTRYPOINT flask run --host=0.0.0.0 --port=8080
