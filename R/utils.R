
# Criar listas de parâmetros
cria_param <- function(nome, vec) {
  
  # Se vec for nulo, retornar string vazia
  if (is.null(vec)) { return(NULL) }
  
  # Criar string da chamada
  vec <- stringr::str_c(nome, "=", vec)
  vec <- stringr::str_c(vec, sep = "&")
  return(vec)
}

#' @importFrom magrittr %>%
magrittr::`%>%`

globalVariables("uri")
