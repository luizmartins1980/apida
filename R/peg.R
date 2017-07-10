# Pegar bloco
peg_bloco <- function(id_bloco, n_max = 15) {
  
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
peg_legislatura <- function(id_legislatura, n_max = 15) {
  
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