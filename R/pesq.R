
# Pesquisar blocos
pesq_bloco <- function(id_bloco = NULL, id_legislatura = NULL,
                       sigla_partido = NULL, n_max = 15) {
  
  # Constantes da chamada
  base <- "https://dadosabertos.camara.leg.br/api/v2/blocos?"
  fim <- "ordem=ASC&ordenarPor=nome"
  
  # Criar listas de parâmetros
  id_bloco <- cria_param("id", id_bloco)
  id_legislatura <- cria_param("idLegislatura", id_legislatura)
  sigla_partido <- cria_param("siglaPartido", sigla_partido)
  
  # Unir todos os parâmetros da chamada
  params <- stringr::str_c(
    id_bloco, id_legislatura,
    sigla_partido, fim, sep = "&")
  
  # Construir chamada
  cham <- stringr::str_c(base, params)
  
  # Executar chamada
  res <- jsonlite::fromJSON(cham)
  
  # Formatar resultados
  saida <- dplyr::select(res$dados, -uri) %>% tibble::as_tibble()
  names(saida) <- c("id_bloco", "siglas_partidos", "id_legislatura")
  
  return(saida)
}

# Pesquisar partidos
pesq_partido <- function(sigla_partido = NULL, data_inicio = NULL,
                         data_fim = NULL, id_legislatura = NULL, n_max = 15) {
  
  # Constantes da chamada
  base <- "https://dadosabertos.camara.leg.br/api/v2/partidos?"
  fim <- "ordem=ASC&ordenarPor=sigla"
  
  # Criar listas de parâmetros
  sigla_partido <- cria_param("siglaPartido", sigla_partido)
  data_inicio <- cria_param("dataInicio", data_inicio)
  data_fim <- cria_param("dataFim", data_fim)
  id_legislatura <- cria_param("idLegislatura", id_legislatura)
  
  # Unir todos os parâmetros da chamada
  params <- stringr::str_c(
    sigla_partido, data_inicio, data_fim,
    id_legislatura, fim, sep = "&")
  
  # Construir chamada
  cham <- stringr::str_c(base, params)
  
  # Executar chamada
  res <- jsonlite::fromJSON(cham)
  
  # Formatar resultados
  saida <- dplyr::select(res$dados, -uri) %>% tibble::as_tibble()
  names(saida) <- c("id_partido", "sigla_partido", "nome_partido")
  
  return(saida)
}
