Cria um cluster da aplicação myimages (https://github.com/my-prototypes/tflk.git)

```shell
.
├── README.md
├── docker
|	├── app-server.dockerfile
│	└── commands.sh
├── docker-compose.yml
└── docs
```

O cluster tem 2 nós sendo um nó do servidor de aplicação e outro nó do banco de dados. 

1. Faça um docker compose para buidar as imagens necessarias

```shell
$ docker-compose build
```

2. Suba os containers via docker compose up

```shell
$ docker-compose up
```

3. Liste os containers
```shell
$ docker container ls 
```

Devera aparecer

CONTAINER ID        IMAGE                  COMMAND                  CREATED             STATUS              PORTS                    NAMES
f658bbaea3fc        armandoss/app-server   "/root/tflk…"            2 minutes ago       Up About a minute   0.0.0.0:8080->5000/tcp   app-server-1
b4f04b6a1395        mysql:5.6              "docker-entrypoint.s…"   2 minutes ago       Up About a minute   0.0.0.0:3306->3306/tcp   compose_mydb_1

4. Abra o browser em http://localhost:5000

Obs: para persistir os dados do banco de dados e preciso criar um volume no arquivo docker-compose.yml
