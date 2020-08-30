.onAttach <- function(libname, pkgname) {
  packageStartupMessage("The Singularity Package is now available")
}


.onLoad <- function(libname, pkgname) {
  op <- options()

  # TODO: Load the default options from the default config
  op.singularity <- list(
    singularity.path = ''
  )

  toset <- !(names(op.singularity) %in% names(op))
  if (any(toset)) {
    options(op.singularity[toset])
  }

  invisible()
}
