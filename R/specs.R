#' @include utils.R
NULL

#' Title
#'
#' @param file
#' @param folder
#'
#' @return
#' @export
#'
#' @examples
#' folder<-system.file("examples", package = "rjd3tramoseatsx")
#' file<-"example.7"
#' q<-read_spec_file(file, folder)
#' rjd3tramoseats::tramoseats_fast(q$series, q$spec, q$context)
read_spec_file<-function(file, folder=NULL){
  if (is.null(folder))
    jrslt<-.jcall("jdplus/tramoseatsx/base/core/Utility",  "Ljdplus/tramoseatsx/base/core/Decoder$Document;", "readDocument", as.character(file), .jnull("java/lang/String"))
  else
    jrslt<-.jcall("jdplus/tramoseatsx/base/core/Utility",  "Ljdplus/tramoseatsx/base/core/Decoder$Document;", "readDocument", as.character(file), as.character(folder))
  if (is.jnull(jrslt)) return (NULL)

  name<-.jcall(jrslt, "Ljava/lang/String;", "getName")
  jts<-.jcall(jrslt, "Ljdplus/toolkit/base/api/timeseries/TsData;", "getSeries")
  if (is.jnull(jts))
    s<-NULL
  else
    s<-rjd3toolkit::.jd2r_tsdata(jts)
  jspec<-.jcall(jrslt, "Ljdplus/tramoseats/base/api/tramoseats/TramoSeatsSpec;", "getSpec")
  if (is.jnull(jspec))
    spec<-NULL
  else
    spec<-rjd3tramoseats::.jd2r_spec_tramoseats(jspec)
  jcxt<-.jcall(jrslt, "Ljdplus/toolkit/base/api/timeseries/regression/ModellingContext;", "getContext")
  if (is.jnull(jcxt))
    context<-NULL
  else
    context<-rjd3toolkit::.jd2r_modellingcontext(jcxt)

  return (list(
    name=name,
    series=s,
    spec=spec,
    context=context
  ))
}
