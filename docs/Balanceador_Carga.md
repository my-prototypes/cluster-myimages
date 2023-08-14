# Usando o Nginx como balanceador de carga

É possível usar o [Nginx](https://en.wikipedia.org/wiki/Nginx) como [balanceador de carga](https://en.wikipedia.org/wiki/Load_balancing_(computing)) em um cluster Docker. O Nginx é um servidor web popular e um servidor proxy reverso que geralmente é usado como um balanceador de carga para distribuir o tráfego de rede de entrada em vários servidores ou contêineres de back-end. Ele pode desempenhar um papel crucial para garantir que a carga de trabalho seja distribuída uniformemente entre os contêineres do cluster, melhorando o desempenho, a disponibilidade e a confiabilidade.

## Passos básicos de configuração de um balanceador de carga

Veja como você pode configurar o Nginx como um balanceador de carga em um cluster do Docker:

1. Crie contêineres do Docker: primeiro, você precisa ter seu aplicativo da Web em contêineres usando o Docker. Cada instância do seu aplicativo será executada em seu próprio contêiner.

2. Configurar contêiner Nginx: você pode criar um contêiner Docker separado especificamente para executar o Nginx como o balanceador de carga. Nesse contêiner, você configurará o Nginx para atuar como um proxy reverso que encaminha as solicitações recebidas para os contêineres de back-end.

3. Configure o Nginx: dentro do contêiner Nginx, você configurará o arquivo nginx.conf para definir o comportamento do balanceamento de carga, por exemplo: [Round-robin_scheduling](https://en.wikipedia.org/wiki/Round-robin_scheduling). Você pode especificar os endereços e as portas dos contêineres de back-end, configurar algoritmos de balanceamento de carga e configurar verificações de integridade.

4. Vincule o Nginx aos contêineres de back-end: certifique-se de que o contêiner Nginx possa se comunicar com os contêineres de back-end. Isso pode envolver vincular o contêiner Nginx a uma rede comum compartilhada com os contêineres de back-end.

5. Tráfego de roteamento: quando as solicitações chegam ao balanceador de carga Nginx, ele as encaminha para o contêiner de back-end apropriado com base em sua configuração de balanceamento de carga. O Nginx pode usar algoritmos como round-robin ou conexões mínimas para distribuir o tráfego.

6. Dimensionar e manter: à medida que você dimensiona seu cluster do Docker adicionando mais contêineres, o Nginx ajusta automaticamente seu comportamento de balanceamento de carga para acomodar as novas instâncias.

## Exemplo de configuração 

Aqui está um exemplo simplificado de um arquivo de configuração Nginx (nginx.conf) para balanceamento de carga:

```bash
http {
     infra-estrutura upstream {
         servidor back-end-container-1:80;
         servidor back-end-container-2:80;
         # Adicione mais contêineres de back-end conforme necessário
     }

     servidor {
         ouvir 80;
        
         localização / {
             proxy_pass http://back-end;
             proxy_set_header Host $host;
             proxy_set_header X-Real-IP $remote_addr;
         }
     }
}
```

Neste exemplo, o bloco upstream lista os endereços e as portas do contêiner de back-end. O bloco do servidor define a configuração do próprio balanceador de carga. As solicitações para o IP ou domínio do balanceador de carga serão encaminhadas para os contêineres de back-end usando o algoritmo de balanceamento de carga especificado.

Ao usar o Nginx como um balanceador de carga em seu cluster Docker, você pode distribuir o tráfego com eficiência, melhorar o desempenho do aplicativo e garantir alta disponibilidade gerenciando solicitações em várias instâncias do seu aplicativo da web.

## Exemplo de aplicacão

User1 e User2 acessam as instâncias App-Server1 e App-Server2 através do balancedor de carga Load-Balancer. 

O contêiner "Load Balancer" continua a distribuir solicitações recebidas entre "App Server 1" e "App Server 2".

Os contêineres "App Server 1" e "App Server 2" hospedam instâncias de seu aplicativo da web.

Ambos os contêineres "App Server" se comunicam com o contêiner compartilhado "DB Server" para operações de banco de dados. Essa configuração garante que ambos os servidores de aplicativos interajam com o mesmo servidor de banco de dados, mantendo a consistência dos dados.

As setas ainda indicam o fluxo de solicitações e dados. As solicitações são direcionadas do balanceador de carga para os servidores de aplicativos e os servidores de aplicativos se comunicam com o servidor de banco de dados compartilhado.

Essa configuração permite obter balanceamento de carga e redundância entre os servidores de aplicativos, mantendo um único servidor de banco de dados compartilhado para armazenamento e recuperação de dados.

Diagrama simplificado de Balanceador de Carga com dois servidores de aplicação: 

```bash
@startuml

rectangle "User1" as user1
rectangle "User2" as user2
rectangle "Load Balancer (Nginx)" as lb
rectangle "App Server 1" as app1
rectangle "App Server 2" as app2
rectangle "DB Server" as db

user1 -down-> lb
user2 -down-> lb
lb -down-> app1
lb -down-> app2
app1 -down-> db
app2 -down-> db

@enduml
```

![Diagrama Load Balancer](https://github.com/my-prototypes/cluster-myimages/blob/main/docs/load_balancer_simplificado.png "Diagrama Simplificado Balanceador de Carga")

Diagrama detalhado de Balanceador de Carga com dois servidores de aplicação: 

```bash
@startuml MyImages
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

!define DEVICONS https://raw.githubusercontent.com/tupadr3/plantuml-icon-font-sprites/master/devicons
!define FONTAWESOME https://raw.githubusercontent.com/tupadr3/plantuml-icon-font-sprites/master/font-awesome-5
!include DEVICONS/html5.puml
!include DEVICONS/python.puml
!include DEVICONS/mysql.puml
!include DEVICONS/nginx.puml
!include FONTAWESOME/users.puml

Person(user1, "User1")
Container(web_client1, "Browser1", "html", "The main interface that the customer interacts with", $sprite="html5") 

Person(user2, "User2")
Container(web_client2, "Browser2", "html", "The main interface that the customer interacts with", $sprite="html5") 

System_Boundary(c0, "Load Balancer"){
    Container(load_balancer, "Load Balancer", "Nginx", "Control users requests", $sprite="nginx")
}

System_Boundary(c1, "MyImages Web Aplication Instance 1") {    
    Container(web_app1, "Web Application", "Python, Flask", "Allows users to manage images", $sprite="python")    
    Container(archive1, "archive1", "File Images")
}

System_Boundary(c2, "MyImages Web Aplication Instance 2") {    
    Container(web_app2, "Web Application", "Python, Flask", "Allows users to manage images", $sprite="python")
    Container(archive2, "archive2", "File Images")
}

System_Boundary(c3, "Data Base"){
    ContainerDb(db, "Database", "MySQL", "Holds users and images information", $sprite="mysql")
}

Rel_Down(user1, web_client1, "Uses")
Rel_Down(web_client1, load_balancer, "Uses", "https")
Rel_Down(user2, web_client2, "Uses")
Rel_Down(web_client2, load_balancer, "Uses", "https")
Rel_Down(load_balancer, web_app1, "Uses session1", "https")
Rel_Down(load_balancer, web_app2, "Uses session2", "https")
Rel_Down(web_app1,db, "session1 Reads/Writes")
Rel_L(web_app1, archive1, "Writes", "files")
Rel_L(web_app2, archive2, "Writes", "files")
Rel_Down(web_app2,db, "session2 Reads/Writes")

SHOW_LEGEND()

@enduml
```

![Diagrama Load Balancer](https://github.com/my-prototypes/cluster-myimages/blob/main/docs/load_balancer.png "Diagrama Detalhado Balanceador de Carga")
