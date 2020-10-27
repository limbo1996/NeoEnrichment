#' calculate p and nes for simulation
#'
#' @param es Es.
#' @param neo_list Neoantigen list.
#' @param test Mutation file.
#'
#' @return es,nes,p

cal_p_and_normalized_simulation <- function(es,neo_list,test){
  sample_res <- data.frame(res=rep(1,1000))
  for (i in 1:1000) {
    neoantigen_list <- sample(test$mutation_id,length(neo_list),replace = F)
    sample_res$res[i] <- cales_simulation(test,neoantigen_list)
  }
  #p <- ifelse(es<0,mean(sample_res$res<es),mean(sample_res$res>es))
  nes <- ifelse(es<0,es/abs(mean(sample_res$res[sample_res$res<0])),
                es/mean(sample_res$res[sample_res$res>0]))
  es_p <- paste(es,nes,sep = ",")
}