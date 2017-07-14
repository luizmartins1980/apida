
# Pesquisar blocos
pesq_blocos <- function(id_legislatura = NULL, sigla_partido = NULL,
                        n_max = 15) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-1, -1)
  base <- "blocos?"
  fim <- "ordem=ASC&ordenarPor=id"
  
  # Realizar chamada para a API
  res <- chamar_api(args, base, fim)
  
  # Formatar resultados
  saida <- tibble::as_tibble(res) %>% dplyr::select(-uri)
  names(saida) <- c("id_bloco", "siglas_partidos", "id_legislatura")
  
  return(saida)
}

# Pesquisar partidos
pesq_partidos <- function(data_inicio = NULL, data_fim = NULL,
                          id_legislatura = NULL, n_max = 15) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-1, -1)
  base <- "partidos?"
  fim <- "ordem=ASC&ordenarPor=id"
  
  # Realizar chamada para a API
  res <- chamar_api(args, base, fim)
  
  # Formatar resultados
  saida <- tibble::as_tibble(res) %>% dplyr::select(-uri)
  names(saida) <- c("id_partido", "sigla_partido", "nome_partido")
  
  return(saida)
}

# Pesquisar deputados
pesq_deputados <- function(id_legislatura = NULL, sigla_uf = NULL,
                           sigla_partido = NULL, sigla_sexo = NULL,
                           n_max = 15) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-1, -1)
  base <- "deputados?"
  fim <- "ordem=ASC&ordenarPor=id"
  
  # Realizar chamada para a API
  res <- chamar_api(args, base, fim)
  
  # Formatar resultados
  saida <- tibble::as_tibble(res) %>% 
    dplyr::select(-dplyr::starts_with("uri"))
  names(saida) <- c("id_deputado", "nome_deputado", "sigla_partido",
                    "sigla_uf", "id_legislatura", "url_foto")
  
  return(saida)
}

# Pesquisar legislaturas
pesq_legislaturas <- function(data = NULL, n_max = 15) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-1, -1)
  base <- "legislaturas?"
  fim <- "ordem=ASC&ordenarPor=id"
  
  # Realizar chamada para a API
  res <- chamar_api(args, base, fim)
  
  # Formatar resultados
  saida <- tibble::as_tibble(res) %>% dplyr::select(-uri)
  names(saida) <- c("id_legislatura", "data_inicio", "data_fim")
  
  return(saida)
}


# Pesquisar despesas de um deputado
pesq_despesas_deputado <- function(id_deputado, id_legislatura = NULL,
                                   ano = NULL, mes = NULL,
                                   cnpj_cpf_fornecedor = NULL, n_max = 15) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-2, -1)
  base <- stringr::str_c("deputados/", id_deputado, "/despesas?")
  fim <- "ordem=ASC&ordenarPor=numAno"
  
  # Realizar chamada para a API
  res <- chamar_api(args, base, fim)
  
  # Formatar resultados
  saida <- tibble::as_tibble(res) %>%
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
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-2, -1)
  base <- stringr::str_c("deputados/", id_deputado, "/eventos?")
  fim <- "ordem=ASC&ordenarPor=dataInicio"
  
  # Realizar chamada para a API
  res <- chamar_api(args, base, fim)
  
  # Formatar resultados
  saida <- tibble::as_tibble(res) %>% dplyr::select(-uri)
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
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-2, -1)
  base <- stringr::str_c("deputados/", id_deputado, "/orgaos?")
  fim <- "ordem=ASC&ordenarPor=dataInicio"
  
  # Realizar chamada para a API
  res <- chamar_api(args, base, fim)
  
  # Formatar resultados
  saida <- tibble::as_tibble(res)
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
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-1, -1)
  base <- "eventos?"
  fim <- "ordem=ASC&ordenarPor=id"
  
  # Realizar chamada para a API
  res <- chamar_api(args, base, fim)

  # Formatar resultados
  names(res$orgao) <- stringr::str_c(names(res$orgao), "_orgao")
  names(res$localCamara) <- stringr::str_c(names(res$localCamara), "_local")
  res <- res %>% append(res$orgao) %>% append(res$localCamara)
  res$orgao <- NULL; res$localCamara <- NULL
  saida <- tibble::as_tibble(res) %>% dplyr::select(-uri, -uri_orgao)
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
                             id_situacao = NULL, cod_partido = NULL, n_max = 15) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-1, -1)
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

# Pesquisar órgãos legislativos
pesq_orgaos <- function(id_tipo_orgao = NULL, data_inicio = NULL,
                        data_fim = NULL, n_max = 15) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-1, -1)
  base <- "orgaos?"
  fim <- "ordem=ASC&ordenarPor=sigla"
  
  # Realizar chamada para a API
  res <- chamar_api(args, base, fim)
  
  # Formatar resultados
  saida <- res %>% tibble::as_tibble() %>% dplyr::select(-uri)
  names(saida) <- c("id_orgao", "sigla_orgao", "nome_orgao",
                    "id_tipo_orgao", "tipo_orgao")
  
  return(saida)
}

pesq_tramitacoes_proposicao <- function(id_proposicao) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-2, -1)
  base <- stringr::str_c("proposicoes/", id_proposicao, "/tramitacoes?")
  fim <- ""
  
  # Realizar chamada para a API
  res <- chamar_api(args, base, fim)
  
  # Formatar resultados
  saida <- tibble::as_tibble(res) %>% dplyr::select(-uriOrgao)
  names(saida) <- c("data_hora", "sequencia", "sigla_orgao",
                    "regime", "descricao_tramitacao", "id_tipo_tramitacao",
                    "descricao_situacao", "id_situacao", "despacho", "url")
  
  return(saida)
}















