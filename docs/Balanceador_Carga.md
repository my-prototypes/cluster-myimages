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
         servidor back-end-container-3:80;
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
