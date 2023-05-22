# Teste Voting App

## Resumo

### Cluster Kubernetes
Instalado usando o K3S, usando instancias ec2 free tier.

### Network
A base da rede foi criada com uma VPC, e subnets privadas e públicas, neste teste foram usadas apenas as públicas. 

Foi Criado um ELB para responder como porta de entrada dos sites para o Cluster

Utilizei um domínio de teste para configurar os sites, usando um record wildcard no Route53.

### CI/CD

Foi criado um módulo chamado `registry` para usar o ECR
Utlizando o Github Actions a pipeline foi construida com os passos básicos: Build, Push e Deploy no Kubernetes. 

### Log
Foi utilizado o Loki para capturar logs com o Promtail e visualização no Grafana

