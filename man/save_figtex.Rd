% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/figtex.R
\name{save_figtex}
\alias{save_figtex}
\title{Create a plot, and create a tex figure string}
\usage{
save_figtex(
  plot,
  title,
  caption,
  size = "third",
  figure.dir = "results/figures",
  latex.dir = "results/tex",
  margins = 0.75,
  type = c("pdf", "png", "both"),
  res = 300,
  latex = TRUE
)
}
\arguments{
\item{plot}{The plot to save}

\item{title}{The title of the plot, which will serve as a base file name, and the
latex label.}

\item{caption}{A description of the figure. This will be input into the latex file.}

\item{size}{The dimensions of the generated file. Takes either a string, or a vector
of lencth 2, as c('height', 'width'). String optsion are:
\describe{
    \item{full}{Full page}
    \item{half}{Half of the page, folded height-wise}
    \item{quarter}{One quarter of the page, folded height and width-wise}
    \item{third}{One third of the page, folded height-wise}
    \item{sixth}{One sixth of the page, folded in half width-wise, and in a
           third height-wise}
}}

\item{figure.dir}{Which directory to save the file.}

\item{latex.dir}{Which directory to save the latex include file.}

\item{margins}{The margins of the main file to which the figure is intended to be
saved.}

\item{type}{What to save the raw image as, either as a pdf or a png.}

\item{latex}{Create a latex include file.}
}
\value{
Print out file names and save the include string to the cliopboard.
}
\description{
This function takes a plot object and prints it out as a file onto the disk, either
as a png or a pdf. The dimensions of the figure can be specified manually or using
some convinient options. The location of the saved figure can be specifed. Optionally,
this function will generate a latex-file of the generated plot that can be input into
a master tex document. This will include a caption that is specied as an argument.
}
