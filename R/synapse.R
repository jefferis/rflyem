#' Read flyem format synapse.json file
#'
#' @param x The path to a flyem synapse.json file (or a URL)
#'
#' @return A list containing two \code{dataframe}s: \itemize{
#'
#'   \item{\code{tbars}} containing information about presynaptic T Bars
#'
#'   \item{\code{partners}} detailing the postsynaptic partners for each T bar. }
#' @export
#' @importFrom jsonlite read_json
#' @importFrom dplyr bind_rows
#' @examples
#' f=system.file('testdata/testsynapse.json', package = 'rflyem')
#' s <- read_synapse(f)
#' summary(s$partners)
#' plot(s$partners[,c("x","y")], asp=1)
read_synapse <- function(x){
  synapse=read_json(x, simplifyVector = TRUE)

  # first process tbars
  tbars=synapse[['data']][['T-bar']]
  if(is.null(tbars))
    stop("Malformed file. Cannot find tbars data!")
  tbars=fix_location(tbars)
  attr(tbars,'metadata')=synapse$metadata

  partners=bind_rows(synapse$data$partners)
  # I assume that the incoming list of data.frames has one row for each
  # t bar so make a set of ids for those
  partners$tbarid=rep(seq_along(synapse$data$partners), sapply(synapse$data$partners, nrow))
  partners=fix_location(partners)

  list(tbars=tbars, partners=partners)
}

# helper function to turn a single list based location column into 3 columns
fix_location <- function(x) {
  if(!is.data.frame(x))
    stop("I need a data.frame!")
  if(!"location" %in% names(x))
    stop("No location data in this input data.frame!")
  locs=matrix(unlist(x$location), ncol=3, byrow = TRUE)
  # remove old location column
  x$location=NULL
  colnames(locs)=c("x","y","z")
  cbind(x, locs)
}
