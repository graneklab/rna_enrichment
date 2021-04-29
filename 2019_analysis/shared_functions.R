library(readr)
library(foreach)
library(fs)
library(stringr)
library(tidyr)

mycombine <- function(df1, df2) {
  # Combine two data frames by gene names
  #
  # Args:
  #   df1 (Dataframe): the first count data
  #   df2 (Dataframe): the second count data
  #
  # Returns:
  #   (Dataframe) The combined data frame of df1 and df2
  full_join(df1, df2, by = "gene")
}

loadStarCounts = function(countfile_paths) {
  # Data type for each column
  coltypes <-
    list(col_character(),
         col_integer(),
         col_integer(),
         col_integer())
  
  out <- foreach(count_path = countfile_paths, .combine = mycombine) %do% {
    # generate rowname (extracted from count file name)
    count_path %>%
      path_file %>%
      str_replace(count_suffix, "") ->
      readset_label
    
    # read in the count file
    readr::read_tsv(count_path, col_names = FALSE, col_types = coltypes) %>%
      dplyr::select(X1, X4) %>% # get the 1st and 4th columns (gene ids and second strand read counts)
      dplyr::rename_(.dots = setNames(names(.), c("gene", readset_label)))
  }
  
  
  # Drop STAR count statistics and rotate dataframe
  out %>%
    dplyr::slice(-(1:4)) %>%
    gather(expid, value,-gene) %>%
    spread(gene, value) -> genecounts
  return(genecounts)
}
