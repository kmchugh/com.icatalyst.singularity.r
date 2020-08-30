Singularity <- R6::R6Class("Singularity",
  lock_objects = FALSE,
  private = list(
    client_id = NULL,
    client_secret = NULL
  ),
  public = list(

    initialize = function(client_id, client_secret, config_file = '.local.config.json') {
      stopifnot(
        is.character(client_id),
        is.character(client_secret),
        is.character(config_file)
      )

      # Load the default configs then the local overrides
      files <- c(system.file('extdata', 'default.config.json', package='com.icatalyst.singularity', mustWork=TRUE),
        system.file('extdata', '.local.config.json', package='com.icatalyst.singularity'))

      for (file in files[files!=""]) {
        settings <- rjson::fromJSON(file=file)

        # Update the properties from the properties file
        for (name in names(settings)) {
          self[[name]] <- settings[[name]]
        }
      }
    },
    print = function(...) {
      cat("Singularity\n")
      cat("  Client ID:", self$client_id, "\n", sep="")
      cat("  Server URL:", self$server_uri, "\n", sep="")
      invisible(self);
    }
  )
)
