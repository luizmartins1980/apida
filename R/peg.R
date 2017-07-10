# Pegar bloco
peg_bloco <- function(id_bloco, n_max = 15) {
  
  # Constantes da chamada
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