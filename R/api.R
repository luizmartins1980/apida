# Realizar uma chamada de pesquisa para a API
pesq_api <- function(args, base, n_max) {
  
  # URL base da chamada
  url <- "https://dadosabertos.camara.leg.br/api/v2/"
  base <- stringr::str_c(url, base)
  
  # Nomes originais dos argumentos da API
  nomes <- args %>% names() %>% snake_to_camel()
  
  # Criar chamada
  cham <- purrr::map2_chr(nomes, args, cria_param) %>%
    stringr::str_c(collapse = "&") %>%
    stringr::str_c(base, .)
  
  # Realizar primeira chamada e preparar loop
  res <- jsonlite::fromJSON(cham); dados <- res$dados
  if (length(dados) == 0) { return(dados) }
  
  # Repetir chamada caso necessário
  while (!is.null(res$links) & length(dados[[1]]) < n_max) {
    
    # Realizar chamada
    res <- jsonlite::fromJSON(res$links$href[2])
    dados_ <- res$dados
    
    # Juntar dados
    dados <- zip_rec(dados, dados_)
    
    # Interromper o loop caso não haja mais dados
    if (all(res$links$rel != "next")) { break() }
  }
  
  return(dados)
}

# Realizar uma chamada de pegue para a API
peg_api <- function(base, id, ...) {
  
  # Preparação do URL
  url <- "https://dadosabertos.camara.leg.br/api/v2/"
  base <- stringr::str_c(url, base)
  
  # Função temporária para acumulação
  acc <- function(x, y) {
    stringr::str_c(base, y, ...) %>% 
      jsonlite::fromJSON() %>% 
      .$dados %>%
      null_to_na() %>%
      zip_rec(x, .)
  }
  
  # Acumular dados das chamadas
  dados <- purrr::reduce(id, acc, .init = NULL)
  
  return(dados)
}
