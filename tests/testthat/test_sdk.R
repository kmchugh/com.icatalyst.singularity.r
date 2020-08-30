context('Singularity SDK')
library(com.icatalyst.singularity)

test_that('the constructor requires client_id and client_secret', {
  client_id <- 'a client id'
  client_secret <- 'a client secret'
  sut = com.icatalyst.singularity::Singularity$new('a client id', 'a client secret', 'a client key')
  expect_true(R6::is.R6(sut))
})


test_that('the default configuration loads correctly', {
  client_id <- 'a client id'
  client_secret <- 'a client secret'
  sut = com.icatalyst.singularity::Singularity$new('a client id', 'a client secret', 'a client key')
  expect_equal(sut$server_uri, 'https://api.singularity.icatalyst.com')

  expect_equal(sut$endpoints[['token']], '/token')
})

test_that('it can create a javascript message handler for shiny', {
  client_id <- 'a client id'
  client_secret <- 'a client secret'
  sut = com.icatalyst.singularity::Singularity$new('a client id', 'a client secret', 'a client key')

  expect_equal(
    'Shiny.addCustomMessageHandler(\'singularity_redirect\', function(message) {window.location = \'https://api.singularity.icatalyst.com\';});',
    sut$shiny_redirect_code)

  sut = com.icatalyst.singularity::Singularity$new('a client id', 'a client secret', 'a client key', config=list(
    server_uri = 'https://test.test.com'
  ))

  expect_equal(
    'Shiny.addCustomMessageHandler(\'singularity_redirect\', function(message) {window.location = \'https://test.test.com\';});',
    sut$shiny_redirect_code)

  sut = com.icatalyst.singularity::Singularity$new('a client id', 'a client secret', 'a client key')
  sut$shiny_tags(
    tags = list(
      head = function(a){
        return(a)
      },
      script = function(a){
        print(a)
        expect_equal(
          'Shiny.addCustomMessageHandler(\'singularity_redirect\', function(message) {window.location = \'https://www.testing.test.com\';});',
          sut$shiny_redirect_code)
      }
    ),
    redirect_uri = 'https://www.testing.test.com'
  )

  expect_equal(
    'Shiny.addCustomMessageHandler(\'singularity_redirect\', function(message) {window.location = \'https://www.testing.test.com\';});',
    sut$shiny_redirect_code)
})

