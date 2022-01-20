## Descrição 

-

## Como rodar 

### Configuração 

Para executar o sistema é preciso configurar as variáveis de ambiente *AWS_ACCESS_KEY_ID* e *AWS_SECRET_ACCESS_KEY* que são utilizadas para acessar a conta AWS contendo as filas sqs e o bucket S3, para configurar basta executar o comando

```bash
export AWS_ACCESS_KEY_ID=***
export AWS_SECRET_ACCESS_KEY=***
```

É necessário instalar as dependencias rodando o arquivo do respectivo sistema operacional localizado na pasta **setup**

### Rodando o programa

Para rodar basta executar o script entrypoint