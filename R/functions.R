#' Quickly load the Rfunctions package
#'
#' Load the package at 'bin/Rfunctions'
quick_load = function(){ devtools::load_all('bin/Rfunctions') }

#' Install the Rfunctions package
#'
#' Shortcut to document and install the R package at 'bin/Rfunction'.
#' Also, reload Rstudio.
quick_install = function(){
    devtools::document('bin/Rfunctions/')
    devtools::install('bin/Rfunctions')
    .rs.restartR()
}


#' Quickly print inf rows
#'
pp = function(df){print(df, n=Inf)}

#' Quickly print inf columns
#'
pw = function(df){ print(df, width=Inf) }


