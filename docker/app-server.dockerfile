#app-server.dockerfile
FROM ubuntu:20.04

MAINTAINER Armando Soares <armando@ufpi.edu.br>

WORKDIR /root

# install git, pip, vim
RUN apt-get update && apt-get install -y git python3 python3-pip vim

# Faz o clone de repositorio tflk
RUN git clone https://github.com/my-prototypes/tflk.git

# Vai para o diretorio /root/tflk
WORKDIR /root/tflk

# set environment variable
ENV FLASK_APP=run.py
ENV FLASK_ENV=development
ENV MY_SECRET_KEY=S3crEtMy2023

COPY /docker/commands.sh /root/tflk/commands.sh
RUN ["chmod", "+x", "/root/tflk/commands.sh"]
ENTRYPOINT ["/root/tflk/commands.sh"]

EXPOSE 5000