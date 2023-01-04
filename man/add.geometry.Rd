\name{add.geometry}
\alias{add.geometry}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Convert a data.frame into an sf LINESTRING object 
}
\description{
Adds a 'geometry' column connecting the locations for each individual}
\usage{
add.geometry(df, na.rm=TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{df}{
a dataframe in Euring format, typically read in by{\code{\link{read.euring2000}}}
}
  \item{na.rm}{
logical, should NA's be removed? 
}
}
\details{
Creates an object which can be used as the basis for {\code{\link{draw.recmap}}}
}
\value{
The dataframe is returned with an added 'geometry' column, which contains a LINESTRING (duplicated within each individual)
}
\author{
Rob Robinson
}
\keyword{ manip }
\keyword{ spatial }
\\
