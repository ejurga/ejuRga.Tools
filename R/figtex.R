

#' Write latex string for figure generation
#'
#' Internal function, write the string for the tex input file for a
#' generated figure
#'
#' @param caption The caption
#' @param figure.path The relative path of the figure to be included
#' @param title The title of the figure.
write_latex_string = function(caption, figure.path, title){

    format.path = gsub(x=figure.path, '_', '\\_', fixed=TRUE)

    string =
        sprintf(R.version.string, date(), figure.path, caption, format.path, title,
        fmt =
'%% Latex figure generated by %s
%% %s
\\begin{figure}[!h]
    \\centering
    \\includegraphics{%s}
    \\caption{
    %s
    \\newline
    Path: \\texttt{%s}
    }
    \\label{fig:%s}
\\end{figure}')
}

#' Create file name and print plot
#'
#' Internal function for \code{save_figtex}
#'
make_plot_file = function(type, plot, figure.dir, title, res, width, height){

    if (type=='pdf'){
        file.path = paste0(figure.dir,'/',title,'.pdf')
        pdf(file=file.path, width=width, height=height)
        print(plot)
        dev.off()
    } else if (type=='png'){
        file.path = paste0(figure.dir,'/',title,'.png')
        png(filename=file.path, width=width, height=height,
            units='in', res=res)
        print(plot)
        dev.off()
    }
    return(file.path)
}

#' Create a plot, and create a tex figure string
#'
#' This function takes a plot object and prints it out as a file onto the disk, either
#' as a png or a pdf. The dimensions of the figure can be specified manually or using
#' some convinient options. The location of the saved figure can be specifed. Optionally,
#' this function will generate a latex-file of the generated plot that can be input into
#' a master tex document. This will include a caption that is specied as an argument.
#'
#' @param plot The plot to save
#' @param title The title of the plot, which will serve as a base file name, and the
#' latex label.
#' @param caption A description of the figure. This will be input into the latex file.
#' @param size The dimensions of the generated file. Takes either a string, or a vector
#' of lencth 2, as c('height', 'width'). String optsion are:
#' \describe{
#' 	\item{full}{Full page}
#' 	\item{half}{Half of the page, folded height-wise}
#' 	\item{quarter}{One quarter of the page, folded height and width-wise}
#' 	\item{third}{One third of the page, folded height-wise}
#' 	\item{sixth}{One sixth of the page, folded in half width-wise, and in a
#'		       third height-wise}
#'}
#' @param margins The margins of the main file to which the figure is intended to be
#' saved.
#' @param type What to save the raw image as, either as a pdf or a png.
#' @param figure.dir Which directory to save the file.
#' @param latex.dir Which directory to save the latex include file.
#' @param latex Create a latex include file.
#'
#' @return Print out file names and save the include string to the cliopboard.
#'
#' @export
save_figtex = function(plot,
                       title,
                       caption='',
                       size='third',
                       figure.dir='results/figures',
                       latex.dir='results/tex',
                       margins=0.75,
                       type=c('pdf', 'png', 'both'),
                       res=300,
                       latex=TRUE){

    require(clipr)

    # Match args
    type = match.arg(type)

    # Ensure the 'title' of the figure is unique amoung those figures in the figures
    # directory!
    if(length(grep(title, list.files(figure.dir)))>=1){
        warning('title exists, overwriting')
    }

    # Parse out the size of the figure!
    dim = list()
    dim$h = 11  - margins*2
    dim$w = 8.5 - margins*2
    # If string for the size:
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
    # If the size is a two element vector:
    } else if (is.numeric(size)) {
        if (length(size)!=2) {
            stop('vector "size" must be of length 2')
        } else {
            height = size[1]
            width  = size[2]
        }
    }

    # Plot the figures!
    if (type!='both'){
        figure.path = make_plot_file(type, plot, figure.dir, title, res, width, height)
        print(sprintf('Created figure at file: %s', figure.path))
    } else {
        make_plot_file(type='pdf', plot, figure.dir, title, res, width, height)
        figure.path = make_plot_file(type='png', plot, figure.dir, title, res, width, height)
        print(sprintf('Created png and pdf file, png is at %s', figure.path))
    }

    # Create the latex document
    if(latex==TRUE){
        # Create the tex document for that file.
        tex.path = paste0(latex.dir, '/', title, '.tex')
        write(file=tex.path, x=write_latex_string(caption, figure.path, title))

        # Print out for info, and copy the path to the clipboard.
        print('Input string for latex document. Copied also to clipboard')
        input.string = sprintf('\\input{%s}', tex.path)
        cat(input.string, '\n')
        clipr::write_clip(input.string, allow_non_interactive = TRUE)
    }
}










