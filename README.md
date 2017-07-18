# apida

[![Travis-CI Build Status](https://travis-ci.org/ctlente/apida.svg?branch=master)](https://travis-ci.org/ctlente/apida) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ctlente/apida?branch=master&svg=true)](https://ci.appveyor.com/project/ctlente/apida) [![Coverage Status](https://img.shields.io/codecov/c/github/ctlente/apida/master.svg)](https://codecov.io/github/ctlente/apida?branch=master)

## Geral

`apida` é um pacote R para acessar a API do serviço
[Dados Abertos da Câmara dos Deputados](https://dadosabertos.camara.leg.br/swagger/api.html).

Este pacote tem dois tipos de funções: `pesq` (de "pesquisar") e `peg` (de "pegar").
No geral, as funções `pesq_<categoria>` trazem informações superficiais sobre um
subconjunto de uma categoria (deputados, partidos, etc.). Já as funções `peg_<categoria>`
trazem informações mais profundas sobre um ou mais elementos específicos da categoria em questão.

## A fazer

O `apida` ainda está em desenvolvimento ativo! Esta é uma lista do que já foi feito
e do que ainda há de ser implementado (OBS.: as funções relacionadas a votações não foram
implementadas porque a API ainda não as suporta).

Geral
- [X] Implementar `n_max`
- [X] Implementar testes
- [X] `peg_*` recebem vetores
- [ ] Documentar funções

Blocos
- [X] `/blocos`: Lista de dados sobre os blocos partidários
- [X] `/blocos/{id}`: Informações sobre um bloco partidário específico

Votações
- [ ] `/votacoes/{id}`: Retorna um conjunto de informações mais detalhadas sobre a
votação identificada por id
- [ ] `/votacoes/{id}/votos`: Listagem de votantes

Partidos
- [X] `/partidos`: Os partidos políticos que têm ou já tiveram parlamentares em
exercício na Câmara
- [X] `/partidos/{id}`: Informações detalhadas sobre um partido

Deputados
- [X] `/deputados`: Listagem e busca de deputados, segundo critérios
- [X] `/deputados/{id}`: Informações detalhadas sobre um deputado específico
- [X] `/deputados/{id}/despesas`: As despesas com exercício parlamentar do deputado
- [X] `/deputados/{id}/eventos`: Uma lista de eventos com a participação do parlamentar
- [X] `/deputados/{id}/orgaos`: Os órgãos dos quais um deputado é integrante

Legislaturas
- [X] `/legislaturas`: Os períodos de mandatos e atividades parlamentares da Câmara
- [X] `/legislaturas/{id}`: Informações extras sobre uma determinada legislatura
da Câmara
- [X] `/legislaturas/{id}/mesa`: Quais deputados fizeram parte da Mesa Diretora em uma
legislatura

Proposições
- [X] `/proposicoes`: Lista configurável de proposições na Câmara
- [X] `/proposicoes/{id}`: Informações detalhadas sobre uma proposição específica
- [X] `/proposicoes/{id}/tramitacoes`: O histórico de passos na tramitação de uma
proposta
- [ ] `/proposicoes/{id}/votacoes`: As votações por quais uma proposição já passou

Eventos
- [X] `/eventos`: Lista de eventos ocorridos ou previstos nos diversos órgãos da
Câmara
- [X] `/eventos/{id}`: Informações detalhadas sobre um evento específico

Órgãos
- [X] `/orgaos`: A lista das comissões e outros órgãos legislativos da Câmara
- [X] `/orgaos/{id}`: Informações detalhadas sobre um órgão legislativo
- [X] `/orgaos/{id}/eventos`: Informações detalhadas sobre um órgão legislativo

Referências
- [X] `/referencias/situacoesDeputado`: As possíveis situações de exercício parlamentar
de um deputado
- [X] `/referencias/situacoesEvento`: As possíveis situações para eventos
- [X] `/referencias/situacoesOrgao`: As situações em que órgãos podem se encontrar
- [X] `/referencias/situacoesProposicao`: Os possíveis estados de tramitação de uma
proposição
- [X] `/referencias/tiposEvento`: Os tipos de eventos realizados na Câmara
- [X] `/referencias/tiposOrgao`: Os tipos de órgãos que existem na Câmara
- [X] `/referencias/tiposProposicao`: Os vários tipos de proposições existentes
- [X] `/referencias/uf`: Identificadores dos estados e do Distrito Federal
