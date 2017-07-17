library(apida)

context("Funções peg_*")

test_that("As funções peg_* retornam objetos do formato esperado", {
  
  # Funções peg_* normais
  expect_equal(dim(peg_bloco(570)), c(1, 3))
  expect_equal(dim(peg_deputado(73441)), c(1, 23))
  expect_equal(dim(peg_evento(48092)), c(1, 17))
  expect_equal(dim(peg_legislatura(13)), c(1, 3))
  # expect_equal(dim(peg_mesa(13)), c(15, 0))
  expect_equal(dim(peg_orgao(2003)), c(1, 12))
  expect_equal(dim(peg_partido(36779)), c(1, 12))
  expect_equal(dim(peg_proposicao(12677)), c(1, 26))
  
  # Referências
  expect_equal(dim(peg_referencia("situacoesDeputado")), c(8, 2))
  expect_equal(dim(peg_referencia("situacoesEvento")), c(9, 2))
  expect_equal(dim(peg_referencia("situacoesOrgao")), c(20, 2))
  expect_equal(dim(peg_referencia("situacoesProposicao")), c(79, 2))
  expect_equal(dim(peg_referencia("tiposEvento")), c(31, 2))
  expect_equal(dim(peg_referencia("tiposOrgao")), c(41, 2))
  expect_equal(dim(peg_referencia("tiposProposicao")), c(419, 4))
  expect_equal(dim(peg_referencia("uf")), c(27, 3))
})
