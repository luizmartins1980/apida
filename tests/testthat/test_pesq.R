library(apida)

context("Funções pesq_*")

test_that("As funções pesq_* retornam objetos do formato esperado", {
  
  # Partidos
  # expect_equal(dim(pesq_blocos()), c(2, 3))
  expect_equal(dim(pesq_partidos()), c(15, 3))

  # Deputados
  expect_equal(dim(pesq_deputados()), c(15, 6))
  expect_equal(dim(pesq_despesas_deputado(73441)), c(15, 16))
  expect_equal(dim(pesq_eventos_deputado(73441)), c(15, 9))
  expect_equal(dim(pesq_orgaos_deputado(73441)), c(15, 6))

  # Orgãos
  expect_equal(dim(pesq_orgaos()), c(15, 5))
  expect_equal(dim(pesq_eventos_orgao(2003)), c(3, 16))

  # Proposições
  expect_equal(dim(pesq_proposicoes()), c(15, 6))
  expect_equal(dim(pesq_tramitacoes_proposicao(12673)), c(8, 10))

  # Eventos
  expect_equal(dim(pesq_eventos()), c(15, 16))

  # Legislaturas
  expect_equal(dim(pesq_legislaturas()), c(15, 3))
})
