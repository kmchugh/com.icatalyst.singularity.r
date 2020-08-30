context('Singularity SDK')
library(com.icatalyst.singularity)

test_that('the constructor requires client_id and client_secret', {
  client_id <- 'a client id'
  client_secret <- 'a client secret'
  sut = com.icatalyst.singularity::Singularity$new('a client id', 'a client secret')
  expect_true(R6::is.R6(sut))
})


test_that('the default configuration loads correctly', {
  client_id <- 'a client id'
  client_secret <- 'a client secret'
  sut = com.icatalyst.singularity::Singularity$new('a client id', 'a client secret')
  expect_equal(sut$server_uri, 'https://api.singularity.icatalyst.com')

  expect_equal(sut$endpoints[['token']], '/token')


})

