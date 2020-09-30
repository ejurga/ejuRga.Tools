#' Convinience function for modifying ggplot legend sizes in a consistent way
#'
#' @param size Size of the title, text, and boxes of the legend, in pt
#' @export
gglegend_size = function(size){
  t = theme(legend.key.size=unit(size, 'pt'),
            legend.text=element_text(size=size),
            legend.title=element_text(size=size, face='bold'))
  return(t)
}

#' Return named vector of 20 custom colors
#'
#' Use this function to return a custom named list of 20 colors. These are somewhat
#' useful for metagenomic graphs.
#'
#' @param ... If blank: return all 20 colors. If a single integer, return that amount of colors.
#' Otherwise, specify the colors, by name. Possible colors: "red", "green", "blue",
#' "orange", "purple", "cyan", "magenta", "lime", "pink", "yellow", "teal", "lavender",
#' "brown", "beige", "maroon", "mint", "olive", "apricot", "navy", "grey".
#'
#' '@returns Vector of colors. If specifying names, a named vector is returned.
#' @export
twentycol = function(...) {

    cols = c(...)

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

    if (is.null(cols)) {
        return(unname(palette))
    } else if (is.numeric(cols)) {
        return(unname(palette[1:cols]))
    } else {
        return(palette[cols])
    }
}

