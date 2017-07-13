# Pegar bloco
peg_bloco <- function(id_bloco) {
  
  # Constante da chamada
  base <- "https://dadosabertos.camara.leg.br/api/v2/blocos/"
  
  # Construir chamada
  cham <- stringr::str_c(base, id_bloco)
  
  # Executar chamada
  res <- jsonlite::fromJSON(cham)
  
  # Formatar resultados
  saida <- tibble::as_tibble(res$dados) %>% dplyr::select(-uri)
  names(saida) <- c("id_bloco", "siglas_partidos", "id_legislatura")
  
  return(saida)
}

# Pegar partido
peg_partido <- function(id_partido) {
  
  # Constante da chamada
  base <- "https://dadosabertos.camara.leg.br/api/v2/partidos/"
  
  # Construir chamada
  cham <- stringr::str_c(base, id_partido)
  
  # Executar chamada
  res <- jsonlite::fromJSON(cham)
  
  # Formatar resultados
  res$dados$status$lider <- res$dados$status$lider$id
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
  
  # Constantes da chamada
  base <- "https://dadosabertos.camara.leg.br/api/v2/deputados/"
  
  # Construir chamada
  cham <- stringr::str_c(base, id_deputado)
  
  # Executar chamada
  res <- jsonlite::fromJSON(cham)
  
  # Formatar resultados
  saida <- res$dados %>% purrr::modify_if(~length(.x) == 0, ~NA) %>%
    purrr::flatten() %>% purrr::flatten_df() %>%
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
  
  # Constante da chamada
  base <- "https://dadosabertos.camara.leg.br/api/v2/legislaturas/"
  
  # Construir chamada
  cham <- stringr::str_c(base, id_legislatura)
  
  # Executar chamada
  res <- jsonlite::fromJSON(cham)
  
  # Formatar resultados
  saida <- tibble::as_tibble(res$dados) %>% dplyr::select(-uri)
  names(saida) <- c("id_legislatura", "data_inicio", "data_fim")
  
  return(saida)
}

# Pegar mesa
peg_mesa <- function(id_legislatura) {
  
  # Constante da chamada
  base <- "https://dadosabertos.camara.leg.br/api/v2/legislaturas/"
  
  # Construir chamada
  cham <- stringr::str_c(base, id_legislatura, "/mesa")
  
  # Executar chamada
  res <- jsonlite::fromJSON(cham)
  
  # Formatar resultados
  saida <- tibble::as_tibble(res[[1]]) %>%
    dplyr::select(id, nome, nomePapel)
  names(saida) <- c("id_deputado", "nome_deputado", "nome_papel")
  
  return(saida)
}

# Pegar evento
peg_evento <- function(id_evento) {
  
  # Constante da chamada
  base <- "https://dadosabertos.camara.leg.br/api/v2/eventos/"
  
  # Construir chamada
  cham <- stringr::str_c(base, id_evento)
  
  # Executar chamada
  res <- jsonlite::fromJSON(cham)
  
  # Formatar resultados
  names(res$dados$orgaos) <- stringr::str_c(names(res$dados$orgaos), "_orgao")
  names(res$dados$localCamara) <- stringr::str_c(names(res$dados$localCamara), "_local")
  saida <- res$dados %>%
    purrr::flatten() %>%
    purrr::modify_if(~length(.x) == 0, ~NA) %>%
    tibble::as_tibble() %>%
    dplyr::select(-uri, -uri_orgao)
  names(saida) <- c("id_evento", "datahora_inicio", "datahora_fim", "descricao_situacao",
                    "descricao_tipo", "titulo", "id_orgao", "sigla_orgao", "nome_orgao",
                    "id_tipo_orgao", "tipo_orgao", "nome_local", "predio_local", "sala_local",
                    "andar_local")
  
  return(saida)
}
