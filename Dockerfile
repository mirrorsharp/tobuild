FROM python:3.8-slim-buster

ENV FLASK_VERSION=2.1.1

WORKDIR /app

#install required packages
RUN pip3 install --no-cache-dir Flask==${FLASK_VERSION}
COPY . .

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]