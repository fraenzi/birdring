\name{draw.recmap}
\alias{draw.recmap}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Plot recoveries on a map
}
\description{
Draw either an outline map or basemap and add recovery locations, possibly sequentially - see details.
}
\usage{
draw.recmap(df, type = "outline", theme = NULL, subset = NULL,
                    margin = 1, lwd = 1, line.col = "gray", pch = 19, cex
                    = 1, pch.col = "black", fill = TRUE, fill.col =
                    "white", border.col = "black", bg = "lightgray", mar =
                    rep(0.1, 4), ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{df}{
a dataframe in Euring format, typically read in by {\code{\link{read.euring2000}}}.
}
  \item{type}{
a character string, either 'outline' for a simple outline map (using the maps package), or a raster map service using the basemaps package for a list of the available services.
}
  \item{theme}{
if type is a basemap service, a character string indicating which theme to use.
}
  \item{subset}{
a logical expression indicating which rows to use, particularly useful for plotting multiple layers, see details. Note, currently you need to specify the data.frame name for this to evaluate properly, e.g. {\code{df$var==val}}.
}
  \item{margin}{
a numeric scalar, or vector of length 2 that specifies an additional buffer around the points in df, given as longitude_buffer, latitude_buffer (if different).
}
  \item{lwd}{
a numeric scalar indicating thickness of lines between points, use lwd=0 to suppress these. Currently, only one line width and colour are accepted, use sequential calls to differentiate between groups, see details.
}
  \item{line.col}{
the colour of the lines between points. 
}
  \item{pch}{
symbol type, with one, two, or more values, see pch.col.
}
  \item{pch.col}{
colour of the symbols. One value will colour all points the same, two colours will differentiate ringing (pch.col[1]) and subsequent (pch.col[2]) encounters. If more are given, colours will be used sequentially for each location (by date); the colours (excepting the first) will be recycled, with a warning, if necessary.
}
  \item{cex}{
scalar, relative size of the symbols, use cex=0 to suppress.
}
  \item{fill}{
logical, should the land polygons be filled if type='outline'.
}
  \item{fill.col}{
a colour with which to fill the land polygons, if type='outline'.
}
  \item{border.col}{
a colour with which the land borders are drawn, use border.col=NA to suppress these.
}
  \item{bg}{
the background colour (i.e. for the sea), currently overflows the plot region.
}
  \item{mar}{
plot margins, see {\code{?par('mar')}}, an attempt to reduce the white space border.
}
  \item{...}{
further arguments passed to either {\code{maps::map}} or {\code{basemaps::basemap}}
}
}
\details{
Designed to enable quick plotting of locations, so options may be a bit limited. To plot recoveries by group, plot a map first, possibly with both lwd=0 and cex=0, then use subset= on the returned object (which now has a spatial element) to plot each group in turn using add=TRUE (see example). This enables differentiating symbols, colours, or widths/sizes. Use cex=c(1,0) or cex=c(0,1) to plot ringing or subsequent encounters only.
}
\value{
The orginal data.frame with a column ('geometry') appended of sf LINESTRINGs
}
\author{
Rob Robinson
}
\note{
The default projection for 'outline' has "the aspect ratio chosen so that longitude and latitude scales are equivalent at the center of the picture", others are (allegedly) available. The projection for all 'basemap's is web Mercator.

If the margins don't seem to work first time, running the command again often seems to help.
}
\seealso{
\code{maps::map}, \code{basemaps::basemap}, 
}
\examples{
# showing how to build up layers of map
data(lancol)
lancol.sf <- draw.recmap(lancol, lwd=0, cex=0, margin=c(5,3))
map(regions="Germany", fill=TRUE, col="thistle", add=TRUE)
draw.recmap(lancol.sf, subset=lancol.sf$sex.byringer=="F", cex=0.7, pch.col=c("salmon","red"))
draw.recmap(lancol.sf, subset=lancol.sf$sex.byringer=="M", cex=0.7, pch.col=c("lightblue","darkblue"))
}
\keyword{ spatial }
