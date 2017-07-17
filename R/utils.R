# Criar listas de parâmetros
cria_param <- function(nome, vec) {
  
  # Se vec for nulo, retornar string vazia
  if (is.null(vec)) { return(NULL) }
  
  # Criar string da chamada
  vec <- stringr::str_c(nome, "=", vec)
  vec <- stringr::str_c(vec, sep = "&")
  return(vec)
}

# "Zipar" duas listas recursivamente
zip_rec <- function(x, y) {
  if (length(x) == 0) { return(y) }
  purrr::map2(x, y, function(x, y) {
    if(!is.list(x)) { c(x, y) }
    else { zip_rec(x, y) }
  })
}

# Substitui NULLs por NAs recursivamente
null_to_na <- function(x) {
  purrr::map(x, function(x) {
    if(!is.list(x)) {
      if (is.null(x)) { NA } else { x }
    } else {
      null_to_na(x)
    }
  })
}

# Trocar um conjunto de strings de "snake case" para "camel case"
snake_to_camel <- function(string) {
  
  # Aplicar fun no primeiro caractere de uma string
  chg_fst <- function(x, fun) {
    len = stringr::str_length(x)
    stringr::str_c(
      fun(stringr::str_sub(x, 1, 1)),
      stringr::str_sub(x, 2, len))
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

# Trocar um conjunto de strings de "camel case" para "snake case"
camel_to_snake <- function(string) {
    
  # Converter cases
  string %>%
    purrr::map_chr(~stringr::str_replace_all(.x, "([A-Z])", "_\\1")) %>%
    stringr::str_to_lower()
}

# Aplica as funções tail e head em sequência
meio <- function(x, tail, head) {
  x %>% utils::tail(tail) %>% utils::head(head)
}

#' @importFrom magrittr %>%
magrittr::`%>%`

# Livrar-se de alertas espúrios
globalVariables(c("uri", "nome", "uriPartido", "data", "id",
                  "nomePapel", "uriMembros", "uri_orgao", ".",
                  "uriOrgao", "ultimoStatus.data",
                  "ultimoStatus.gabinete.nome", "ultimoStatus.id",
                  "ultimoStatus.nome", "status.data"))
