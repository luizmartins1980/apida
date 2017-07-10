# apida

Um pacote R para acessar a API do serviço
[Dados Abertos da Câmara dos Deputados](https://dadosabertos.camara.leg.br/swagger/api.html)

## Geral

Este pacote tem dois tipos de funções: `pesq` (de "pesquisar") e `peg` (de "pegar").
No geral, as funções `pesq_<categoria>` trazem informações superficiais sobre um
subconjunto de uma categoria (deputados, partidos, etc.). Já as funções `peg_<categoria>`
trazem informações mais profundas sobre um elemento específico da categoria em questão.

## A fazer

Este pacote está em desenvolvimento ativo! Aqui está uma lista do que já foi feito
e do que ainda há de ser feito.

Funcionalidades gerais
- [ ] Implementar `n_max`

Blocos
- [X] `/blocos`: Lista de dados sobre os blocos partidários
- [X] `/blocos/{id}`: Informações sobre um bloco partidário específico

Votações
- [ ] `/proposicoes/{id}/votacoes`: As votações por quais uma proposição já passou
- [ ] `/votacoes/{id}`: Retorna um conjunto de informações mais detalhadas sobre a
votação identificada por id, como o relator, o encaminhamento dado como consequência
da votação e as orientações das bancadas.
- [ ] `/votacoes/{id}/votos`: Listagem de votantes

Partidos
- [X] `/partidos`: Os partidos políticos que têm ou já tiveram parlamentares em
exercício na Câmara
- [ ] `/partidos/{id}`: Informações detalhadas sobre um partido

Deputados
- [X] `/deputados`: Listagem e busca de deputados, segundo critérios
- [X] `/deputados/{id}`: Informações detalhadas sobre um deputado específico
- [X] `/deputados/{id}/despesas`: As despesas com exercício parlamentar do deputado
- [X] `/deputados/{id}/eventos`: Uma lista de eventos com a participação do parlamentar
- [X] `/deputados/{id}/orgaos`: Os órgãos dos quais um deputado é integrante
- [ ] `/legislaturas/{id}/mesa`: Quais deputados fizeram parte da Mesa Diretora em uma
legislatura
- [ ] `/referencias/situacoesDeputado`: As possíveis situações de exercício parlamentar
de um deputado

Legislaturas
- [X] `/legislaturas`: Os períodos de mandatos e atividades parlamentares da Câmara
- [X] `/legislaturas/{id}`: Informações extras sobre uma determinada legislatura
da Câmara
- [ ] `/legislaturas/{id}/mesa`: Quais deputados fizeram parte da Mesa Diretora em uma
legislatura

Referências
- [ ] `/referencias/situacoesDeputado`: As possíveis situações de exercício parlamentar
de um deputado
- [ ] `/referencias/situacoesEvento`: As possíveis situações para eventos
- [ ] `/referencias/situacoesOrgao`: As situações em que órgãos podem se encontrar
- [ ] `/referencias/situacoesProposicao`: Os possíveis estados de tramitação de uma
proposição
- [ ] `/referencias/tiposEvento`: Os tipos de eventos realizados na Câmara
- [ ] `/referencias/tiposOrgao`: Os tipos de órgãos que existem na Câmara
- [ ] `/referencias/tiposProposicao`: Os vários tipos de proposições existentes
- [ ] `/referencias/uf`: Identificadores dos estados e do Distrito Federal

Proposições
- [ ] `/proposicoes`: Lista configurável de proposições na Câmara
- [ ] `/proposicoes/{id}`: Informações detalhadas sobre uma proposição específica
- [ ] `/proposicoes/{id}/tramitacoes`: O histórico de passos na tramitação de uma
proposta
- [ ] `/proposicoes/{id}/votacoes`: As votações por quais uma proposição já passou
- [ ] `/referencias/situacoesProposicao`: Os possíveis estados de tramitação de uma
proposição
- [ ] `/referencias/tiposProposicao`: Os vários tipos de proposições existentes

Eventos
- [ ] `/eventos`: Lista de eventos ocorridos ou previstos nos diversos órgãos da
Câmara
- [ ] `/eventos/{id}`: Informações detalhadas sobre um evento específico
- [ ] `/referencias/situacoesEvento`: As possíveis situações para eventos
- [ ] `/referencias/tiposEvento`: Os tipos de eventos realizados na Câmara

Órgãos
- [ ] `/orgaos`: A lista das comissões e outros órgãos legislativos da Câmara
- [ ] `/orgaos/{id}`: Informações detalhadas sobre um órgão legislativo
- [ ] `/orgaos/{id}/eventos`: Informações detalhadas sobre um órgão legislativo
- [ ] `/referencias/situacoesOrgao`: As situações em que órgãos podem se encontrar