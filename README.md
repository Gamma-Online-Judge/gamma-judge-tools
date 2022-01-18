## Descrição 

-

## Como rodar 

### Configuração 

Para executar o sistema é preciso configurar as variáveis de ambiente *AWS_ACCESS_KEY_ID* e *AWS_SECRET_ACCESS_KEY* que são utilizadas para acessar a conta AWS contendo as filas sqs e o bucket S3, para configurar basta executar o comando

```bash
export AWS_ACCESS_KEY_ID=***
export AWS_SECRET_ACCESS_KEY=***
```

### Utilizando docker

Também é possível rodar a aplicação utilizando o docker sem a necessidade de instalar o cli na máquina.

Primeiro basta realizar o build da imagem apontando o container para alguma tag 

```bash
docker build . -t gamma-judge-bash
```

Logo após para executar o projeto basta executar o container utilizando as variáveis de amiente *AWS_ACCESS_KEY_ID* e *AWS_SECRET_ACCESS_KEY*

```bash
docker run \
    -e AWS_ACCESS_KEY_ID=*** \
    -e AWS_SECRET_ACCESS_KEY=*** \
    gamma-judge-bash
```

Também é possível executar utilizando a configuração do arquiv *.env* executando o comando 

```bash
docker run \
    --env-file .env \
    gamma-judge-bash
```