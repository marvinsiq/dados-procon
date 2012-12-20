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
