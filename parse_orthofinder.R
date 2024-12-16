
#########################################################
#                 set working directory                 #
#########################################################

setwd("/Users/katieemelianova/Desktop/Diospyros/diospyros_R_functions")

#########################################################
#                 read in orthogroup file               #
#########################################################

orthogroups<-read_delim("Orthogroups.tsv")



#########################################################
#    clean up column names to be species names only     #
#########################################################

strings_to_remove<-c("_braker.aa", ".aa")

for (strings in strings_to_remove){
  colnames(orthogroups)<-str_replace(colnames(orthogroups), strings, "")
}

#############################################################################################
#   loop through columns, long-split gene ID and orthogroup membership, adding species ID   #
#############################################################################################

orthogroups_long_list <- lapply(orth %>% dplyr::select(-Orthogroup) %>% colnames(), 
       function(x) orth %>% 
         dplyr::select(Orthogroup, x) %>% 
         separate_longer_delim(c(x), delim = ", ") %>%
         set_colnames(c("Orthogroup", "gene_id")) %>%
         mutate(species=x))

orthogroups_long<-data.frame(do.call(rbind, orthogroups_long_list))





