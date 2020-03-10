#' Quickly print inf rows
#'
#' @export
pp = function(df){print(df, n=Inf)}

#' Quickly print inf columns
#'
#' @export
pw = function(df){ print(df, width=Inf) }

#' Act as a quick source functions hack
#'
#' As title. Quickly document and install custom functions. Also, restart Rstudio.
#'
#' @export
dil = function(){
    devtools::document('src/func')
    devtools::install('src/func/')
    .rs.restartR()
}

#' Return dataframe containing duplicate values
#'
#' Uses tidyeval. This function takes a dataframe and a column in the dataframe, and
#' returns the dataframe filtered for duplicate values in the specified column.
#'
#' @usage filter_dups(df, var, n=1)
#'
#' @param df Dataframe
#' @param var The column name for which to filter the duplicates
#' @param n Return rows containing more then n instances of the specified column.
#'
#' @return A dataframe containing the rows filtered for duplicates in the specified
#' column.
#'
#' @export
filter_dups = function(df, var, n=1) {
    var = enquo(var)
    dups = df %>% group_by(!!var) %>% tally() %>% filter(n>n) %>% pull(!!var)
    df.filt = df %>% filter(!!var %in% dups) %>% arrange(!!var)
    return(df.filt)
}

#' Return named vector of 20 custom colors
#'
#' Use this function to return a custom named list of 20 colors. These are somewhat
#' useful for metagenomic graphs.
#'
#' @return Named list of 20 colors
#'
#' @export
twentycol = function() {

    palette = c( red = '#e6194b',
                 green = '#3cb44b',
                 blue = '#4363d8',
                 orange = '#f58231',
                 purple = '#911eb4',
                 cyan = '#46f0f0',
                 magenta = '#f032e6',
                 lime = '#bcf60c',
                 pink = '#fabebe',
                 yellow = '#ffe119',
                 teal = '#008080',
                 lavender = '#e6beff',
                 brown = '#9a6324',
                 biege = '#fffac8',
                 maroon = '#800000',
                 mint = '#aaffc3',
                 olive = '#808000',
                 apricot = '#ffd8b1',
                 navy = '#000075',
                 grey = '#808080' )

    return(palette)
}

#' Save a figure as a pdf
#' 
#' This function exists as a convienient wrapper around the usual workflow of 
#' saving a ggplot figure as a pdf. The dimensions of the pdf are wrapped into 
#' keywords. The path is handled automatically, as I usually save figures in 
#' the same directory structure for each project. And a convinient option exists
#' to check for the existence of the pdf and not generate it if specified. 
#' 
#' @usage save_figure(fig, size='sixth', filename='scratch.pdf', 
#'        dir='results/figures/', margins=1, units='in', regen=TRUE)
#'
#' @param fig The ggplot object to save
#' @param size The size of the pdf. Takes one of 'full', 'half', 'quarter', 'third', 
#' 	or 'sixth'. Alternatively, supply a vector of lencth 2, as c('height', 'width').
#' \describe{ 
#' 	\item{full}{Full page}
#' 	\item{half}{Half of the page, folded height-wise}
#' 	\item{quarter}{One quarter of the page, folded height and width-wise}
#' 	\item{third}{One third of the page, folded height-wise}
#' 	\item{sixth}{One sixth of the page, folded in half width-wise, and in a 
#'		       third height-wise}
#'}
#' @param filename Name of the file. Include subdirectories.
#' @param dir The default directory to save the files in
#' @param margins The margins of the main file to which the figure is intended to be 
#'        saved.
#' @param regen Whether or not to regenerate the figure on each source, given that the 
#'        figure already exists. Beware of this option, use only on very large figures.
#'
#' @return Nothing, but save the figure as a pdf.
save_figure = function(fig, size='sixth', filename='scratch.pdf',
                       dir='results/figures/', margins=1, regen=TRUE){

    # name = 'test'
    # path = fwd
    # fig=global.net
    # name=NULL

    # Filename
    # Path to file
    full_path = paste0(dir, filename)

    # Regen or not?
    if (regen!=TRUE) {
        if (file.exists(full_path)){
            warning('plot exists with regen set to FALSE; not plotting')
            return(NULL)
        }
    }

    # Parse out the size!
    dim = list()
    dim$h = 11  - margins*2
    dim$w = 8.5 - margins*2
    if (is.character(size)) {
        if (size=='full') {
            height = dim$h
            width  = dim$w
        } else if (size=='half') {
            height = dim$h/2
            width  = dim$w
        } else if (size=='quarter') {
            height = dim$h/2
            width  = dim$w/2
        } else if (size=='third') {
            height = dim$h/3
            width  = dim$w
        } else if (size=='sixth') {
            height = dim$h/3
            width  = dim$w/2
        } else {
            stop('size not of value "full", "half", "quarter", "third", or "sixth"')
        }
    } else if (is.numeric(size)) {
        if (length(size)!=2) {
            stop('vector "size" must be of length 2')
        } else {
            height = size[1]
            width  = size[2]
        }
    }

    pdf(file=full_path, width=width, height=height, title=filename)
    print(fig)
    dev.off()
}

