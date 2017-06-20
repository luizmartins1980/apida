
# Pesquisar blocos
pesq_blocos <- function(id_legislatura = NULL, sigla_partido = NULL,
                        n_max = 15) {
  
  # Constantes da chamada
  base <- "https://dadosabertos.camara.leg.br/api/v2/blocos?"
  fim <- "ordem=ASC&ordenarPor=nome"
  
  # Criar listas de parâmetros
  id_legislatura <- cria_param("idLegislatura", id_legislatura)
  sigla_partido <- cria_param("siglaPartido", sigla_partido)
  
  # Unir todos os parâmetros da chamada
  params <- stringr::str_c(
    id_legislatura, sigla_partido,
    fim, sep = "&")
  
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
pesq_partidos <- function(data_inicio = NULL, data_fim = NULL,
                          id_legislatura = NULL, n_max = 15) {
  
  # Constantes da chamada
  base <- "https://dadosabertos.camara.leg.br/api/v2/partidos?"
  fim <- "ordem=ASC&ordenarPor=sigla"
  
  # Criar listas de parâmetros
  data_inicio <- cria_param("dataInicio", data_inicio)
  data_fim <- cria_param("dataFim", data_fim)
  id_legislatura <- cria_param("idLegislatura", id_legislatura)
  
  # Unir todos os parâmetros da chamada
  params <- stringr::str_c(
    data_inicio, data_fim, id_legislatura,
    fim, sep = "&")
  
  # Construir chamada
  cham <- stringr::str_c(base, params)
  
  # Executar chamada
  res <- jsonlite::fromJSON(cham)
  
  # Formatar resultados
  saida <- dplyr::select(res$dados, -uri) %>% tibble::as_tibble()
  names(saida) <- c("id_partido", "sigla_partido", "nome_partido")
  
  return(saida)
}

# Pesquisar deputado
pesq_deputados <- function(id_legislatura = NULL, sigla_uf = NULL,
                           sigla_partido = NULL, sigla_sexo = NULL,
                           n_max = 15) {
  
  # Constantes da chamada
  base <- "https://dadosabertos.camara.leg.br/api/v2/deputados?"
  fim <- "ordem=ASC&ordenarPor=nome"
  
  # Criar listas de parâmetros
  id_legislatura <- cria_param("idLegislatura", id_legislatura)
  sigla_uf <- cria_param("siglaUf", sigla_uf)
  sigla_partido <- cria_param("siglaPartido", sigla_partido)
  sigla_sexo <- cria_param("siglaSexo", sigla_sexo)
  
  # Unir todos os parâmetros da chamada
  params <- stringr::str_c(
    id_legislatura, sigla_uf, sigla_partido,
    sigla_sexo, fim, sep = "&")
  
  # Construir chamada
  cham <- stringr::str_c(base, params)
  
  # Executar chamada
  res <- jsonlite::fromJSON(cham)
  
  # Formatar resultados
  saida <- res$dados %>%
    dplyr::select(-dplyr::starts_with("uri")) %>%
    tibble::as_tibble()
  names(saida) <- c("id_deputado", "nome_deputado", "sigla_partido",
                    "sigla_uf", "id_legislatura", "url_foto")
  
  return(saida)
}

# Pesquisar despesas de um deputado
pesq_despesas <- function(id_deputado, id_legislatura = NULL,
                          ano = NULL, mes = NULL, cpf_cnpj = NULL,
                          n_max = 15) {
  
  # Constantes da chamada
  base <- stringr::str_c(
    "https://dadosabertos.camara.leg.br/api/v2/deputados/",
    id_deputado, "/despesas?")
  fim <- "ordem=ASC&ordenarPor=numAno"
  
  # Criar listas de parâmetros
  id_legislatura <- cria_param("idLegislatura", id_legislatura)
  ano <- cria_param("ano", ano)
  mes <- cria_param("mes", mes)
  cpf_cnpj <- cria_param("cnpjCpfFornecedor", cpf_cnpj)
  
  # Unir todos os parâmetros da chamada
  params <- stringr::str_c(
    id_legislatura, ano, mes,
    cpf_cnpj, fim, sep = "&")
  
  # Construir chamada
  cham <- stringr::str_c(base, params)
  
  # Executar chamada
  res <- jsonlite::fromJSON(cham)
  
  # Formatar resultados
  saida <- tibble::as_tibble(res$dados)
  names(saida) <- c("ano", "mes", "tipo_despesa",
                    "id_documento", "tipo_documento",
                    "data_documento", "num_documento",
                    "valor_documento", "url_documento",
                    "nome_fornecedor", "cpf_cnpj_fornecedor",
                    "valor_liquido", "valor_glosa",
                    "num_ressarcimento", "id_lote", "parcela")
  
  return(saida)
}













