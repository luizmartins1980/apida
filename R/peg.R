#' Pegar informações de um ou mais blocos de partidos
#' 
#' @param id_bloco Identificador(es) do(s) bloco(s)
#' 
#' @export
peg_bloco <- function(id_bloco) {
  
  # Realizar chamada para a API
  base <- "blocos/"
  dados <- peg_api(base, id_bloco)
  
  # Formatar resultados
  saida <- tibble::as_tibble(dados) %>% dplyr::select(-uri)
  names(saida) <- c("id_bloco", "siglas_partidos", "id_legislatura")
  
  return(saida)
}

#' Pegar informações de um ou mais partidos
#' 
#' @param id_partido Identificador(es) do(s) partido(s)
#' 
#' @export
peg_partido <- function(id_partido) {
  
  # Realizar chamada para a API
  base <- "partidos/"
  dados <- peg_api(base, id_partido)

  # Formatar resultados
  dados$status$lider <- dados$status$lider$id
  saida <- dados %>%
    rlist::list.flatten() %>%
    tibble::as_tibble() %>%
    dplyr::select(
      -dplyr::contains("uri"),
      -status.data)
  names(saida) <- c("id_partido", "sigla_partido", "nome_partido",
                    "id_legislatura", "situacao", "total_posse",
                    "total_membros", "id_deputado_lider",
                    "numero_eleitoral", "url_logo", "url_website",
                    "url_facebook")
  
  return(saida)
}

#' Pegar informações de um ou mais deputados
#' 
#' @param id_deputado Identificador(es) do(s) deputado(s)
#' 
#' @export
peg_deputado <- function(id_deputado) {
  
  # Realizar chamada para a API
  base <- "deputados/"
  dados <- peg_api(base, id_deputado)
  
  # Formatar resultados
  saida <- dados %>%
    rlist::list.flatten() %>%
    tibble::as_tibble() %>%
    dplyr::select(
      -dplyr::contains("uri"),
      -ultimoStatus.nome,
      -ultimoStatus.data,
      -ultimoStatus.id,
      -ultimoStatus.gabinete.nome)
  names(saida) <- c("id_deputado", "nome_deputado", "sigla_partido",
             "sigla_uf", "id_legislatura", "url_foto", "nome_eleitoral",
             "predio_escritorio", "sala_escritorio", "andar_escritorio",
             "telefone_escritorio", "email_escritorio", "situacao",
             "condicao_eleitoral", "cpf", "sigla_sexo", "url_website",
             "rede_social", "data_nascimento", "data_falecimento",
             "sigla_uf_nascimento", "municipio_nascimento", "escolaridade")
  
  return(saida)
}

#' Pegar informações de uma ou mais legislaturas
#' 
#' @param id_legislatura Identificador(es) da(s) legislatura(s)
#' 
#' @export
peg_legislatura <- function(id_legislatura) {
  
  # Realizar chamada para a API
  base <- "legislaturas/"
  dados <- peg_api(base, id_legislatura)
  
  # Formatar resultados
  saida <- tibble::as_tibble(dados) %>% dplyr::select(-uri)
  names(saida) <- c("id_legislatura", "data_inicio", "data_fim")
  
  return(saida)
}

#' Pegar informações de uma ou mais mesas de legislaturas
#' 
#' @param id_legislatura Identificador(es) da(s) legislatura(s)
#' 
#' @export
peg_mesa <- function(id_legislatura) {

  # Realizar chamada para a API
  base <- "legislaturas/"
  dados <- peg_api(base, id_legislatura, "/mesa")

  # Formatar resultados
  saida <- tibble::as_tibble(dados) %>%
    dplyr::select(id, nome, nomePapel)
  names(saida) <- c("id_deputado", "nome_deputado", "nome_papel")

  return(saida)
}

#' Pegar informações de um ou mais eventos
#' 
#' @param id_evento Identificador(es) do(s) evento(s)
#' 
#' @export
peg_evento <- function(id_evento) {
  
  # Realizar chamada para a API
  base <- "eventos/"
  dados <- peg_api(base, id_evento)
  
  # Formatar resultados
  saida <- dados %>%
    rlist::list.flatten() %>%
    tibble::as_tibble() %>%
    dplyr::select(
      id, dplyr::everything(),
      -dplyr::contains("uri"))
  names(saida) <- c("id_evento", "fases", "datahora_inicio", "datahora_fim",
                    "descricao_situacao", "descricao_tipo", "titulo",
                    "local_externo", "id_orgao", "sigla_orgao", "nome_orgao",
                    "id_tipo_orgao", "tipo_orgao", "nome_local", "predio_local",
                    "sala_local", "andar_local")
  
  return(saida)
}

#' Pegar informações de uma ou mais proposições
#' 
#' @param id_proposicao Identificador(es) da(s) proposição(s)
#' 
#' @export
peg_proposicao <- function(id_proposicao) {
  
  # Realizar chamada para a API
  base <- "proposicoes/"
  dados <- peg_api(base, id_proposicao)
  
  # Formatar resultados
  saida <- dados %>%
    rlist::list.flatten() %>%
    tibble::as_tibble() %>%
    dplyr::select(-dplyr::contains("uri"))
  names(saida) <- c("id_proposicao", "sigla_tipo", "id_tipo",
                    "numero", "ano", "ementa", "data_apresentacao",
                    "datahora", "sequencia", "sigla_orgao", "regime",
                    "descricao_tramitacao", "id_tipo_tramitacao",
                    "descricao_situacao", "id_situacao", "despacho",
                    "url", "tipo_autor", "id_tipo_autor", "descricao_tipo",
                    "ementa_detalhada", "keywords", "url_inteiro_teor",
                    "urn_final", "texto", "justificativa")
  
  return(saida)
}


#' Pegar informações de um ou mais órgãos legislativos
#' 
#' @param id_orgao Identificador(es) do(s) órgão(s)
#' 
#' @export
peg_orgao <- function(id_orgao) {
  
  # Realizar chamada para a API
  base <- "orgaos/"
  dados <- peg_api(base, id_orgao)
  
  # Formatar resultados
  saida <- dados %>%
    tibble::as_tibble() %>%
    dplyr::select(-uri)
  names(saida) <- c("id_orgao", "sigla_orgao", "nome_orgao",
                    "id_tipo_orgao", "tipo_orgao", "data_inicio",
                    "data_instalacao", "data_fim", "data_fim_original",
                    "casa", "sala", "url_website")
  
  return(saida)
}

#' Pegar tabela de referência de alguma categoria
#' 
#' @param tipo_referencia Tipo da referência (situacoesDeputado,
#' situacoesEvento, situacoesOrgao, situacoesProposicao, tiposEvento,
#' tiposOrgao, tiposProposicao, uf)
#' 
#' @export
peg_referencia <- function(tipo_referencia) {
  
  # Realizar chamada para a API
  base <- "referencias/"
  dados <- peg_api(base, tipo_referencia)
  
  # Formatar resultados
  saida <- tibble::as_tibble(dados) %>% purrr::discard(~all(.x == ""))
  
  return(saida)
}
