import_data <- function(con,query){
# Resources
# https://www.r-bloggers.com/getting-started-with-postgresql-in-r/

  print(con)
  # Output 
  output <- eval(parse(text=query))
 
  # Return Output
  return(output)
}

