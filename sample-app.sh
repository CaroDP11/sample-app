#!/bin/bash

mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

cp sample_app.py tempdir/.
cp requirements.txt tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

echo "FROM python:3.8.2" >> tempdir/Dockerfile
echo "COPY requirements.txt /home/myapp/" >> tempdir/Dockerfile
echo "COPY static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY sample_app.py /home/myapp/" >> tempdir/Dockerfile

echo "WORKDIR /home/myapp" >> tempdir/Dockerfile

echo "RUN python3 -m pip install --upgrade pip" >> tempdir/Dockerfile
echo "RUN python3 -m pip install -r requirements.txt" >> tempdir/Dockerfile

echo "EXPOSE 5050" >> tempdir/Dockerfile
echo "ENV FLASK_DEBUG=1" >> tempdir/Dockerfile

echo "CMD python /home/myapp/sample_app.py" >> tempdir/Dockerfile

cd tempdir
docker build -t sampleapp --no-cache .
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a 