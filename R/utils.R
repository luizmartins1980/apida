
# Criar listas de parâmetros
cria_param <- function(nome, vec) {
  
  # Se vec for nulo, retornar string vazia
  if (is.null(vec)) { return(NULL) }
  
  # Criar string da chamada
  vec <- stringr::str_c(nome, "=", vec)
  vec <- stringr::str_c(vec, sep = "&")
  return(vec)
}

# Trocar um conjunto de strings de "snake case" para "camel case"
snake_to_camel <- function(string) {
  
  # Aplicar fun no primeiro caractere de uma string
  chg_fst <- function(x, fun) {
    len = stringr::str_length(x)
    stringr::str_c(
      fun(stringr::str_sub(x, 1, 1)),
      stringr::str_sub(x, 2, len),
      collapse = "")
  }
  
  # Transformações necessárias para "camel case"
  to_camel <- function(string) {
    stringr::str_split(string, "_") %>%
      purrr::map(~chg_fst(.x, stringr::str_to_upper)) %>%
      purrr::map_chr(~chg_fst(.x, stringr::str_to_lower))
  }
  
  # Aplicar transformação em cada string
  return(purrr::map_chr(string, to_camel))
}

# Realizar uma chamada para a API
chamar_api <- function(args, base, fim) {
  
  # URL base da chamada
  url <- "https://dadosabertos.camara.leg.br/api/v2/"
  base <- stringr::str_c(url, base)
  
  # Nomes originais dos argumentos da API
  nomes <- args %>% names() %>% snake_to_camel()
  
  # Criar e realizar chamada
  res <- purrr::map2_chr(nomes, args, cria_param) %>%
    stringr::str_c(collapse = "&") %>%
    stringr::str_c(fim, sep = "&") %>%
    stringr::str_c(base, .) %>%
    jsonlite::fromJSON()
  
  return(res$dados)
}

#' @importFrom magrittr %>%
magrittr::`%>%`

# Livrar-se de alertas espúrios
globalVariables(c("uri", "nome", "uriPartido", "data", "id",
                  "nomePapel", "uriMembros", "uri_orgao"))
