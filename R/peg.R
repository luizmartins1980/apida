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
    dplyr::select(-uri, -nome, -uriPartido)
  nomes <- c("id_deputado", "nome_deputado", "sigla_partido",
             "sigla_uf", "id_legislatura", "url_foto", "data",
             "nome_eleitoral", "predio_escritorio", "sala_escritorio",
             "andar_escritorio", "telefone_escritorio",
             "email_escritorio", "situacao", "condicao_eleitoral",
             "cpf", "sigla_sexo", "url_website", "rede_social",
             "data_nascimento", "data_falecimento", "sigla_uf_nascimento",
             "municipio_nascimento", "escolaridade")
  
  return(saida)
}
