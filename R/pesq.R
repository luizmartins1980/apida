# Pesquisar blocos
pesq_blocos <- function(id_legislatura = NULL, sigla_partido = NULL,
                        n_max = 15) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-1, -1)
  base <- "blocos?"
  
  # Realizar chamada para a API
  dados <- chamar_api(args, base, n_max)
  if (length(dados) == 0) { return(dados) }
  
  # Formatar resultados
  saida <- tibble::as_tibble(dados) %>% dplyr::select(-uri)
  names(saida) <- c("id_bloco", "siglas_partidos", "id_legislatura")
  
  return(utils::head(saida, n_max))
}

# Pesquisar partidos
pesq_partidos <- function(data_inicio = NULL, data_fim = NULL,
                          id_legislatura = NULL, n_max = 15) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-1, -1)
  base <- "partidos?"
  
  # Realizar chamada para a API
  dados <- chamar_api(args, base, n_max)
  if (length(dados) == 0) { return(dados) }
  
  # Formatar resultados
  saida <- tibble::as_tibble(dados) %>% dplyr::select(-uri)
  names(saida) <- c("id_partido", "sigla_partido", "nome_partido")
  
  return(utils::head(saida, n_max))
}

# Pesquisar deputados
pesq_deputados <- function(id_legislatura = NULL, sigla_uf = NULL,
                           sigla_partido = NULL, sigla_sexo = NULL,
                           n_max = 15) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-1, -1)
  base <- "deputados?"
  
  # Realizar chamada para a API
  dados <- chamar_api(args, base, n_max)
  if (length(dados) == 0) { return(dados) }
  
  # Formatar resultados
  saida <- tibble::as_tibble(dados) %>% 
    dplyr::select(-dplyr::starts_with("uri"))
  names(saida) <- c("id_deputado", "nome_deputado", "sigla_partido",
                    "sigla_uf", "id_legislatura", "url_foto")
  
  return(utils::head(saida, n_max))
}

# Pesquisar legislaturas
pesq_legislaturas <- function(data = NULL, n_max = 15) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-1, -1)
  base <- "legislaturas?"
  
  # Realizar chamada para a API
  dados <- chamar_api(args, base, n_max)
  if (length(dados) == 0) { return(dados) }
  
  # Formatar resultados
  saida <- tibble::as_tibble(dados) %>% dplyr::select(-uri)
  names(saida) <- c("id_legislatura", "data_inicio", "data_fim")
  
  return(utils::head(saida, n_max))
}


# Pesquisar despesas de um deputado
pesq_despesas_deputado <- function(id_deputado, id_legislatura = NULL,
                                   ano = NULL, mes = NULL,
                                   cnpj_cpf_fornecedor = NULL, n_max = 15) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-2, -1)
  base <- stringr::str_c("deputados/", id_deputado, "/despesas?")
  
  # Realizar chamada para a API
  dados <- chamar_api(args, base, n_max)
  if (length(dados) == 0) { return(dados) }
  
  # Formatar resultados
  saida <- tibble::as_tibble(dados) %>%
    dplyr::mutate_at(.vars = c(1, 2, 8, 12, 13, 16),
                     .funs = as.numeric)
  names(saida) <- c("ano", "mes", "tipo_despesa",
                    "id_documento", "tipo_documento",
                    "data_documento", "num_documento",
                    "valor_documento", "url_documento",
                    "nome_fornecedor", "cpf_cnpj_fornecedor",
                    "valor_liquido", "valor_glosa",
                    "num_ressarcimento", "id_lote", "parcela")
  
  return(utils::head(saida, n_max))
}

# Pesquisar eventos de um deputado
pesq_eventos_deputado <- function(id_deputado, data_inicio = NULL,
                                 data_fim = NULL, n_max = 15) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-2, -1)
  base <- stringr::str_c("deputados/", id_deputado, "/eventos?")
  
  # Realizar chamada para a API
  dados <- chamar_api(args, base, n_max)
  if (length(dados) == 0) { return(dados) }
  
  # Formatar resultados
  saida <- tibble::as_tibble(dados) %>% dplyr::select(-uri)
  names(saida) <- c("id_evento", "datahora_inicio",
                    "datahora_fim", "situacao_evento",
                    "tipo_evento", "titulo",
                    "local_camara", "local_externo",
                    "sigla_orgao")
  
  return(utils::head(saida, n_max))
}

# Pesquisar órgãos de um deputado
pesq_orgaos_deputado <- function(id_deputado, data_inicio = NULL,
                                  data_fim = NULL, n_max = 15) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-2, -1)
  base <- stringr::str_c("deputados/", id_deputado, "/orgaos?")
  
  # Realizar chamada para a API
  dados <- chamar_api(args, base, n_max)
  if (length(dados) == 0) { return(dados) }
  
  # Formatar resultados
  saida <- tibble::as_tibble(dados)
  names(saida) <- c("id_orgao", "sigla_orgao",
                    "nome_orgao", "nome_papel",
                    "data_inicio", "data_fim")
  
  return(utils::head(saida, n_max))
}

# Pesquisar eventos ocorridos ou previstos nos diversos órgãos da Câmara
pesq_eventos <- function(id_tipo_evento = NULL, id_situacao = NULL,
                         id_tipo_orgao = NULL, id_orgao = NULL,
                         data_inicio = NULL, data_fim = NULL,
                         hora_inicio = NULL, hora_fim = NULL, n_max = 15) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-1, -1)
  base <- "eventos?"
  
  # Realizar chamada para a API
  dados <- chamar_api(args, base, n_max)
  if (length(dados) == 0) { return(dados) }

  # Formatar resultados
  names(dados$orgao) <- stringr::str_c(names(dados$orgao), "_orgao")
  names(dados$localCamara) <- stringr::str_c(names(dados$localCamara), "_local")
  dados <- dados %>% append(dados$orgao) %>% append(dados$localCamara)
  dados$orgao <- NULL; dados$localCamara <- NULL
  saida <- tibble::as_tibble(dados) %>% dplyr::select(-uri, -uri_orgao)
  names(saida) <- c("id_evento", "datahora_inicio", "datahora_fim", "descricao_situacao",
                    "descricao_tipo", "titulo", "local_externo", "id_orgao", "sigla_orgao",
                    "nome_orgao", "id_tipo_orgao", "tipo_orgao", "nome_local", "predio_local",
                    "sala_local", "andar_local")
  
  return(utils::head(saida, n_max))
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
  
  # Realizar chamada para a API
  dados <- chamar_api(args, base, n_max)
  if (length(dados) == 0) { return(dados) }
  
  # Formatar resultados
  saida <- dados %>% tibble::as_tibble() %>% dplyr::select(-uri)
  names(saida) <- c("id_proposicao", "sigla_tipo", "id_tipo",
                    "numero", "ano", "ementa")
  
  return(utils::head(saida, n_max))
}

# Pesquisar órgãos legislativos
pesq_orgaos <- function(id_tipo_orgao = NULL, data_inicio = NULL,
                        data_fim = NULL, n_max = 15) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-1, -1)
  base <- "orgaos?"
  
  # Realizar chamada para a API
  dados <- chamar_api(args, base, n_max)
  if (length(dados) == 0) { return(dados) }
  
  # Formatar resultados
  saida <- dados %>% tibble::as_tibble() %>% dplyr::select(-uri)
  names(saida) <- c("id_orgao", "sigla_orgao", "nome_orgao",
                    "id_tipo_orgao", "tipo_orgao")
  
  return(utils::head(saida, n_max))
}

# Pesquisar tramitações de uma proposição
pesq_tramitacoes_proposicao <- function(id_proposicao, n_max = 15) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-2, -1)
  base <- stringr::str_c("proposicoes/", id_proposicao, "/tramitacoes")
  
  # Realizar chamada para a API
  dados <- chamar_api(args, base, n_max)
  if (length(dados) == 0) { return(dados) }
  
  # Formatar resultados
  saida <- tibble::as_tibble(dados) %>% dplyr::select(-uriOrgao)
  names(saida) <- c("data_hora", "sequencia", "sigla_orgao",
                    "regime", "descricao_tramitacao", "id_tipo_tramitacao",
                    "descricao_situacao", "id_situacao", "despacho", "url")
  
  return(utils::head(saida, n_max))
}

# # Pesquisar votações de uma proposição
# pesq_votacoes_proposicao <- function(id_proposicao) {
#   
#   # Informações necessárias para chamar a API
#   args <- match.call() %>% as.list() %>% meio(-2, -1)
#   base <- stringr::str_c("proposicoes/", id_proposicao, "/votacoes")
#   
#   # Realizar chamada para a API
#   dados <- chamar_api(args, base, n_max)
#   if (length(dados) == 0) { return(dados) }
#   
#   # Formatar resultados
#   
#   return(utils::head(saida, n_max))
# }

pesq_eventos_orgao <- function(id_orgao, id_tipo_evento = NULL, n_max = 15) {
  
  # Informações necessárias para chamar a API
  args <- match.call() %>% as.list() %>% meio(-2, -1)
  base <- stringr::str_c("orgaos/", id_orgao, "/eventos")
  
  # Realizar chamada para a API
  dados <- chamar_api(args, base, n_max)
  if (length(dados) == 0) { return(dados) }
  
  # Formatar resultados
  names(dados$orgao) <- stringr::str_c(names(dados$orgao), "_orgao")
  names(dados$localCamara) <- stringr::str_c(names(dados$localCamara), "_local")
  dados <- dados %>% append(dados$orgao) %>% append(dados$localCamara)
  dados$orgao <- NULL; dados$localCamara <- NULL
  saida <- tibble::as_tibble(dados) %>% dplyr::select(-uri, -uri_orgao)
  names(saida) <- c("id_evento", "datahora_inicio", "datahora_fim", "descricao_situacao",
                    "descricao_tipo", "titulo", "local_externo", "id_orgao", "sigla_orgao",
                    "nome_orgao", "id_tipo_orgao", "tipo_orgao", "nome_local", "predio_local",
                    "sala_local", "andar_local")
  
  return(utils::head(saida, n_max))
}
