rm(list=ls())
index         <- charmatch(c("1","2"),c("1","2"));
charvecfun    <- renderText(index)
htmlcharvec   <- textOutput(charvecfun())
holyGrail     <- as.integer(read.table(text = htmlcharvec[["attribs"]][["id"]],sep=" "))

#charvec <- htmlcharvec[["attribs"]][["id"]]
#holyGrail <- as.numeric(read.table(text = charvec,sep=" "))