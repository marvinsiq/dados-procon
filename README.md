dados-procon
============

Sítio da web: ainda não implantado

Missão
------

Disponibilizar dados abertos referentes ao cadastro nacional de reclamações fundamentadas do PROCON de maneira agregada e formatada.

Instalação
----------

Pré-requisitos:
- [Ruby] (http://www.ruby-lang.org)
- [Bundler] (http://gembundler.com)
- [wget] (http://www.gnu.org/software/wget/)
- [MongoDB] (http://www.mongodb.org/)

Baixar gems necessárias:
```
bundle install
```

Preparar ambiente de trabalho:
```
padrino rake data:extraction
padrino rake data:merge
padrino rake seed
```

Iniciar aplicação:
```
padrino start
```
Por favor, visite o site do [Padrino] (http://www.padrinorb.com) para obter mais instruções.

Para enviar e-mails da aplicação é necessário definir três variáveis de ambiente, contendo respectivamente
host do servidor SMTP, e-mail (sender) e senha. Você pode exportar variáveis de ambiente ou criar
o arquivo ".env" na pasta raiz do projeto com as definições das variáveis (mais recomendado).
Exemplo de arquivo ".env".
```
---
EMAIL_SMTP_ADDRESS: smtp.mail.com
EMAIL_USER_NAME: seu_email@teste.com
EMAIL_PASSWORD: sua_senha
```
Obs.: Note que o arquivo está no formato YAML.
