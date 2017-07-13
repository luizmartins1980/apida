
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

# Pesquisar deputados
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

# Pesquisar legislaturas
pesq_legislaturas <- function(data = NULL, n_max = 15) {
  
  # Constantes da chamada
  base <- "https://dadosabertos.camara.leg.br/api/v2/legislaturas?"
  fim <- "ordem=ASC&ordenarPor=id"
  
  # Criar listas de parâmetros
  data <- cria_param("data", data)
  
  # Unir todos os parâmetros da chamada
  params <- stringr::str_c(
    data, fim, sep = "&")
  
  # Construir chamada
  cham <- stringr::str_c(base, params)
  
  # Executar chamada
  res <- jsonlite::fromJSON(cham)
  
  # Formatar resultados
  saida <- dplyr::select(res$dados, -uri) %>% tibble::as_tibble()
  names(saida) <- c("id_legislatura", "data_inicio", "data_fim")
  
  return(saida)
}


# Pesquisar despesas de um deputado
pesq_despesas_deputado <- function(id_deputado, id_legislatura = NULL,
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
  saida <- tibble::as_tibble(res$dados) %>%
    dplyr::mutate_at(.vars = c(1, 2, 8, 12, 13, 16),
                     .funs = as.numeric)
  names(saida) <- c("ano", "mes", "tipo_despesa",
                    "id_documento", "tipo_documento",
                    "data_documento", "num_documento",
                    "valor_documento", "url_documento",
                    "nome_fornecedor", "cpf_cnpj_fornecedor",
                    "valor_liquido", "valor_glosa",
                    "num_ressarcimento", "id_lote", "parcela")
  
  return(saida)
}

# Pesquisar eventos de um deputado
pesq_eventos_deputado <- function(id_deputado, data_inicio = NULL,
                                 data_fim = NULL, n_max = 15) {
  
  # Constantes da chamada
  base <- stringr::str_c(
    "https://dadosabertos.camara.leg.br/api/v2/deputados/",
    id_deputado, "/eventos?")
  fim <- "ordem=ASC&ordenarPor=dataInicio"
  
  # Criar listas de parâmetros
  data_inicio <- cria_param("dataInicio", data_inicio)
  data_fim <- cria_param("dataFim", data_fim)
  
  # Unir todos os parâmetros da chamada
  params <- stringr::str_c(
    data_inicio, data_fim,
    fim, sep = "&")
  
  # Construir chamada
  cham <- stringr::str_c(base, params)
  
  # Executar chamada
  res <- jsonlite::fromJSON(cham)
  
  # Formatar resultados
  saida <- dplyr::select(res$dados, -uri) %>% tibble::as_tibble()
  names(saida) <- c("id_evento", "datahora_inicio",
                    "datahora_fim", "situacao_evento",
                    "tipo_evento", "titulo",
                    "local_camara", "local_externo",
                    "sigla_orgao")
  
  return(saida)
}

# Pesquisar órgãos de um deputado
pesq_orgaos_deputado <- function(id_deputado, data_inicio = NULL,
                                  data_fim = NULL, n_max = 15) {
  
  # Constantes da chamada
  base <- stringr::str_c(
    "https://dadosabertos.camara.leg.br/api/v2/deputados/",
    id_deputado, "/orgaos?")
  fim <- "ordem=ASC&ordenarPor=dataInicio"
  
  # Criar listas de parâmetros
  data_inicio <- cria_param("dataInicio", data_inicio)
  data_fim <- cria_param("dataFim", data_fim)
  
  # Unir todos os parâmetros da chamada
  params <- stringr::str_c(
    data_inicio, data_fim,
    fim, sep = "&")
  
  # Construir chamada
  cham <- stringr::str_c(base, params)
  
  # Executar chamada
  res <- jsonlite::fromJSON(cham)
  
  # Formatar resultados
  saida <- tibble::as_tibble(res$dados)
  names(saida) <- c("id_orgao", "sigla_orgao",
                    "nome_orgao", "nome_papel",
                    "data_inicio", "data_fim")
  
  return(saida)
}

# Pesquisar eventos ocorridos ou previstos nos diversos órgãos da Câmara
pesq_eventos <- function(id_tipo_evento = NULL, id_situacao = NULL,
                         id_tipo_orgao = NULL, id_orgao = NULL,
                         data_inicio = NULL, data_fim = NULL,
                         hora_inicio = NULL, hora_fim = NULL, n_max = 15) {
  
  # Constantes da chamada
  base <- "https://dadosabertos.camara.leg.br/api/v2/eventos?"
  fim <- "ordem=ASC&ordenarPor=id"
  
  # Criar listas de parâmetros
  id_tipo_evento <- cria_param("idTipoEvento", id_tipo_evento)
  id_situacao <- cria_param("idSituacao", id_situacao)
  id_tipo_orgao <- cria_param("idTipoOrgao", id_tipo_orgao)
  id_orgao <- cria_param("idOrgao", id_orgao)
  data_inicio <- cria_param("dataInicio", data_inicio)
  data_fim <- cria_param("dataFim", data_fim)
  hora_inicio <- cria_param("horaInicio", hora_inicio)
  hora_fim <- cria_param("horaFim", hora_fim)
  
  # Unir todos os parâmetros da chamada
  params <- stringr::str_c(
    id_tipo_evento, id_situacao,
    id_tipo_orgao, id_orgao,
    data_inicio, data_fim,
    hora_inicio, hora_fim, fim, sep = "&")
   
  # Construir chamada
  cham <- stringr::str_c(base, params)
  
  # Executar chamada
  res <- jsonlite::fromJSON(cham)
  
  # Formatar resultados
  names(res$dados$orgao) <- stringr::str_c(names(res$dados$orgao), "_orgao")
  names(res$dados$localCamara) <- stringr::str_c(names(res$dados$localCamara), "_local")
  res$dados <- res$dados %>% append(res$dados$orgao) %>% append(res$dados$localCamara)
  res$dados$orgao <- NULL; res$dados$localCamara <- NULL
  saida <- tibble::as_tibble(res$dados) %>% dplyr::select(-uri, -uri_orgao)
  names(saida) <- c("id_evento", "datahora_inicio", "datahora_fim", "descricao_situacao",
                    "descricao_tipo", "titulo", "local_externo", "id_orgao", "sigla_orgao",
                    "nome_orgao", "id_tipo_orgao", "tipo_orgao", "nome_local", "predio_local",
                    "sala_local", "andar_local")
  
  return(saida)
}

# Pesquisar proposições
pesq_proposicoes <- function(sigla_uf_autor = NULL, sigla_tipo = NULL,
                             sigla_partido_autor = NULL, numero = NULL, ano = NULL,
                             data_aprensentacao_inicio = NULL,
                             data_aprensentacao_fim = NULL, data_inicio = NULL,
                             data_fim = NULL, id_autor = NULL, nome_autor = NULL,
                             id_situacao = NULL, cod_partido = NULL, pagina = NULL) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% tail(-1)
  base <- "proposicoes?"
  fim <- "ordem=ASC&ordenarPor=id"
  
  # Realizar chamada para a API
  res <- chamar_api(args, base, fim)
  
  # Formatar resultados
  saida <- res %>% tibble::as_tibble() %>% dplyr::select(-uri)
  names(saida) <- c("id_proposicao", "sigla_tipo", "id_tipo",
                    "numero", "ano", "ementa")
  
  return(saida)
}
