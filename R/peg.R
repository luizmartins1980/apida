# Pegar bloco
peg_bloco <- function(id_bloco) {
  
  # Informações necessárias para chamar a API
  url <- "https://dadosabertos.camara.leg.br/api/v2/"
  base <- "blocos/"
  
  # Realizar chamada para a API
  res <- stringr::str_c(url, base, id_bloco) %>% 
    jsonlite::fromJSON() %>%
    .$dados
  
  # Formatar resultados
  saida <- tibble::as_tibble(res) %>% dplyr::select(-uri)
  names(saida) <- c("id_bloco", "siglas_partidos", "id_legislatura")
  
  return(saida)
}

# Pegar partido
peg_partido <- function(id_partido) {
  
  # Informações necessárias para chamar a API
  url <- "https://dadosabertos.camara.leg.br/api/v2/"
  base <- "partidos/"
  
  # Realizar chamada para a API
  res <- stringr::str_c(url, base, id_partido) %>% 
    jsonlite::fromJSON() %>%
    .$dados

  # Formatar resultados
  res$status$lider <- res$status$lider$id
  saida <- res$dados %>%
    purrr::modify_if(~length(.x) == 0, ~NA) %>%
    purrr::flatten_df() %>%
    dplyr::select(-uri, -uriMembros, -data)
  names(saida) <- c("id_partido", "sigla_partido", "nome_partido",
                    "id_legislatura", "situacao", "total_posse",
                    "total_membros", "id_deputado_lider",
                    "numero_eleitoral", "url_logo", "url_website",
                    "url_facebook")
  
  return(saida)
}

# Pegar deputado
peg_deputado <- function(id_deputado) {
  
  # Informações necessárias para chamar a API
  url <- "https://dadosabertos.camara.leg.br/api/v2/"
  base <- "deputados/"
  
  # Realizar chamada para a API
  res <- stringr::str_c(url, base, id_deputado) %>% 
    jsonlite::fromJSON() %>%
    .$dados
  
  # Formatar resultados
  saida <- res %>%
    purrr::modify_if(~length(.x) == 0, ~NA) %>%
    purrr::flatten() %>%
    purrr::modify_if(~length(.x) == 0, ~NA) %>%
    purrr::flatten_df() %>%
    dplyr::select(-uri, -nome, -uriPartido, -data)
  nomes <- c("id_deputado", "nome_deputado", "sigla_partido",
             "sigla_uf", "id_legislatura", "url_foto", "nome_eleitoral",
             "predio_escritorio", "sala_escritorio", "andar_escritorio",
             "telefone_escritorio", "email_escritorio", "situacao",
             "condicao_eleitoral", "cpf", "sigla_sexo", "url_website",
             "rede_social", "data_nascimento", "data_falecimento",
             "sigla_uf_nascimento", "municipio_nascimento", "escolaridade")
  
  return(saida)
}

# Pegar legislatura
peg_legislatura <- function(id_legislatura) {
  
  # Informações necessárias para chamar a API
  url <- "https://dadosabertos.camara.leg.br/api/v2/"
  base <- "legislaturas/"
  
  # Realizar chamada para a API
  res <- stringr::str_c(url, base, id_legislatura) %>% 
    jsonlite::fromJSON() %>%
    .$dados
  
  # Formatar resultados
  saida <- tibble::as_tibble(res) %>% dplyr::select(-uri)
  names(saida) <- c("id_legislatura", "data_inicio", "data_fim")
  
  return(saida)
}

# Pegar mesa
peg_mesa <- function(id_legislatura) {
  
  # Informações necessárias para chamar a API
  url <- "https://dadosabertos.camara.leg.br/api/v2/"
  base <- "legislaturas/"
  
  # Realizar chamada para a API
  res <- stringr::str_c(url, base, id_legislatura, "/mesa") %>% 
    jsonlite::fromJSON() %>%
    .[[1]]
  
  # Formatar resultados
  saida <- tibble::as_tibble(res) %>%
    dplyr::select(id, nome, nomePapel)
  names(saida) <- c("id_deputado", "nome_deputado", "nome_papel")
  
  return(saida)
}

# Pegar evento
peg_evento <- function(id_evento) {
  
  # Informações necessárias para chamar a API
  url <- "https://dadosabertos.camara.leg.br/api/v2/"
  base <- "eventos/"
  
  # Realizar chamada para a API
  res <- stringr::str_c(url, base, id_evento) %>% 
    jsonlite::fromJSON() %>%
    .$dados

  # Formatar resultados
  names(res$orgaos) <- stringr::str_c(names(res$orgaos), "_orgao")
  names(res$localCamara) <- stringr::str_c(names(res$localCamara), "_local")
  saida <- res %>%
    purrr::modify_if(~length(.x) == 0, ~NA) %>%
    purrr::flatten() %>%
    purrr::modify_if(~length(.x) == 0, ~NA) %>%
    tibble::as_tibble() %>%
    dplyr::select(id, dplyr::everything(), -dplyr::starts_with("uri"))
  names(saida) <- c("id_evento", "fases", "datahora_inicio", "datahora_fim",
                    "descricao_situacao", "descricao_tipo", "titulo", "local_externo",
                    "id_orgao", "sigla_orgao", "nome_orgao", "id_tipo_orgao",
                    "tipo_orgao", "nome_local", "predio_local", "sala_local",
                    "andar_local")
  
  return(saida)
}

# Pegar proposição
peg_proposicao <- function(id_proposicao) {
  
  # Informações necessárias para chamar a API
  url <- "https://dadosabertos.camara.leg.br/api/v2/"
  base <- "proposicoes/"
  
  # Realizar chamada para a API
  res <- stringr::str_c(url, base, id_proposicao) %>% 
    jsonlite::fromJSON() %>%
    .$dados
  
  # Formatar resultados
  saida <- res %>%
    purrr::modify_if(~length(.x) == 0, ~NA) %>%
    purrr::flatten() %>%
    purrr::modify_if(~length(.x) == 0, ~NA) %>%
    tibble::as_tibble() %>%
    dplyr::select(-dplyr::starts_with("uri"))
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

# Pegar órgãos legislativos
peg_orgao <- function(id_orgao) {
  
  # Informações necessárias para chamar a API
  url <- "https://dadosabertos.camara.leg.br/api/v2/"
  base <- "orgaos/"
  
  # Realizar chamada para a API
  res <- stringr::str_c(url, base, id_orgao) %>% 
    jsonlite::fromJSON() %>%
    .$dados
  
  # Formatar resultados
  saida <- res %>%
    purrr::modify_if(~length(.x) == 0, ~NA) %>%
    tibble::as_tibble() %>%
    dplyr::select(-uri)
  names(saida) <- c("id_orgao", "sigla_orgao", "nome_orgao",
                    "id_tipo_orgao", "tipo_orgao", "data_inicio",
                    "data_instalacao", "data_fim", "data_fim_original",
                    "casa", "sala", "url_website")
  
  return(saida)
}

# Função para pegar as tabelas de referências
#
# situacoesDeputado, situacoesEvento, situacoesOrgao
# situacoesProposicao, tiposEvento, tiposOrgao
# tiposProposicao, uf
# 
peg_referencia <- function(tipo_referencia) {
  
  # Informações necessárias para chamar a API
  url <- "https://dadosabertos.camara.leg.br/api/v2/"
  base <- "referencias/"
  
  # Realizar chamada para a API
  res <- stringr::str_c(url, base, tipo_referencia) %>% 
    jsonlite::fromJSON() %>%
    .$dados
  
  # Formatar resultados
  saida <- tibble::as_tibble(res) %>% purrr::discard(~all(.x == ""))
  
  return(saida)
}
