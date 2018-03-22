FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y python-pip python-dev curl git net-tools

COPY ./requirements.txt /app/requirements.txt
RUN pip install Flask && pip install --upgrade pip
COPY ./app.py /app/
WORKDIR /app
ENTRYPOINT [ "python" ]

CMD [ "app.py", "/bin/sh" ]