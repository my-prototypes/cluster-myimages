# Usando o Docker para criar um cluster da aplicação MyImages

Cria um cluster da aplicação myimages (https://github.com/my-prototypes/tflk.git)

```shell
.
├── README.md
├── docker
|	├── app-server.dockerfile
│	└── commands.sh
├── docker-compose.yml
└── docs
    ├── Sobre_o_Docker.md
    ├── Cluster_com_Docker.md
    └── Balanceador_Carga.md
```

# Detalhamento da aplicação

O cluster tem 2 nós sendo um nó do servidor de aplicação e outro nó do banco de dados. 

```bash
@startuml MyImages
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

!define DEVICONS https://raw.githubusercontent.com/tupadr3/plantuml-icon-font-sprites/master/devicons
!define FONTAWESOME https://raw.githubusercontent.com/tupadr3/plantuml-icon-font-sprites/master/font-awesome-5
!include DEVICONS/html5.puml
!include DEVICONS/python.puml
!include DEVICONS/mysql.puml
!include FONTAWESOME/users.puml

Person(user1, "User1")
Container(web_client1, "Browser1", "html", "The main interface that the customer interacts with", $sprite="html5") 

System_Boundary(c1, "MyImages Web Aplication Instance 1") {    
    Container(web_app1, "Web Application", "Python, Flask", "Allows users to manage images", $sprite="python")    
    Container(archive1, "archive1", "File Images")
}

System_Boundary(c2, "Data Base"){
    ContainerDb(db, "Database", "MySQL", "Holds users and images information", $sprite="mysql")
}

Rel_Down(user1, web_client1, "Uses")
Rel_Down(web_client1, web_app1, "Uses")
Rel_Down(web_app1,db, "session1 Reads/Writes")
Rel_L(web_app1, archive1, "Writes", "files")

SHOW_LEGEND()

@enduml
```

![Cluster básico MyImage](https://github.com/my-prototypes/cluster-myimages/blob/main/docs/myimage_cluster_basico.png "Diagrama Cluster Básico do MyImage")

## 1. Faça um docker compose para buidar as imagens necessarias

```shell
docker-compose build
```

### 1.1 Lista as images criadas

```shell
docker image ls
```
Devera aparecer
```bash
REPOSITORY             TAG       IMAGE ID       CREATED          SIZE
armandoss/app-server   latest    ????????????   16 minutes ago   548MB
```
Obs: a [imagem do MySQL](https://hub.docker.com/_/mysql) será baixada do docker repository assim que o cluster for executado

## 2. Suba os containers via docker compose up

```shell
docker-compose up
```

## 3. Liste os containers

```shell
docker container ls 
```
Devera aparecer
```bash
CONTAINER ID        IMAGE                  COMMAND                  CREATED             STATUS              PORTS                    NAMES
????????????        armandoss/app-server   "/root/tflk…"            2 minutes ago       Up About a minute   0.0.0.0:5000->5000/tcp   app-server-1
????????????        mysql:5.6              "docker-entrypoint.s…"   2 minutes ago       Up About a minute   0.0.0.0:3306->3306/tcp   compose_mydb_1
```

## 4. Abra o browser em http://localhost:5000

Obs: para persistir os dados do banco de dados e preciso criar um volume no arquivo docker-compose.yml

## 5. You can perform tests using Play-with-Docker

Run steps 1 and 2 to execute this cluster in [play-with-docker](https://labs.play-with-docker.com)
