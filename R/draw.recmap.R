draw.recmap <-
function(df, type='outline', theme=NULL, subset=NULL, margin=1, 
         lwd=1, line.col="gray", pch=19, cex=1, pch.col="black",
         fill=TRUE, fill.col="white", border.col="black", bg="lightgray",
         mar=rep(0.1,4), ...){
  
  xmargin <- c(-1*margin[1], margin[1])
  if( length(margin) > 1 )
    ymargin <- c(-1*margin[2], margin[2])
  else
    ymargin <- c(-1*margin[1], margin[1])
  add <- FALSE # assume its a dataframe and we need to plot a basemap
  
  if( !is.null(subset) )
    df <- subset(df, subset=subset)
  
  if( any(class(df) == 'sf') ){
    sf <- df
    add <- TRUE # if we get an sf object, assume map has been set up
  }
  else
    sf <- add.geometry(df, na.rm=TRUE)
  
  coords <- as.data.frame(st_coordinates(sf))
  names(coords) <- c('lon', 'lat', 'id')
  coords$seq <- sequence(rle(coords$id)$lengths)
  coords <- st_as_sf(x=coords, coords=c('lon','lat'), crs="EPSG:4326")
  
  if( !add ){
    sf.bbox <- st_bbox(sf)
    
    if( type == "outline" )
      maps::map(xlim=sf.bbox[c(1,3)]+xmargin, ylim=sf.bbox[c(2,4)]+ymargin, lforce="exact",
                fill=fill, col=fill.col, border=border.col, bg=bg, mar=mar, ...)
    else {
      if( is.null(theme) )
        theme <- switch(type, carto='light', `osm-stamen`='toner', esri="world_terrain_base")
      margin <- c(xmargin[1], ymargin[1], xmargin[2], ymargin[2])
      basemaps::basemap(ext=sf.bbox+margin, map_service=type, map_type=theme, ...)
      coords <- st_transform(coords, "EPSG:3857")
      sf$geometry <- st_transform(sf$geometry, "EPSG:3857")
    }
  }
  
  # plot points
  if( cex > 0 ){
    max.enc <- max(as.numeric(dimnames(table(coords$seq))[[1]]))
    # but first sort out colours...
    if( length(pch.col) > 2 ){ # assume plot by sequence number
      if( length(pch.col) < max.enc ){
        warning(paste("pch.col is being recycled to match", max.enc, "encounters"), call.=FALSE)
        pch.col <- rep(pch.col, length.out=max.enc)
        p.cols <- pch.col[coords$seq]
      }
    } else if( length(pch.col) == 2 ){
      p.cols <- rep(pch.col[2], length.out=length(coords$seq))
      p.cols[coords$seq==1] <- pch.col[1]
    } else
      p.cols <- rep(pch.col, length.out=length(coords$seq))
    # ... and symbols
    if( length(pch) > 2 ){ # assume plot by sequence number
      if( length(pch) < max.enc ){
        warning(paste("pch is being recycled to match", max.enc, "encounters"), call.=FALSE)
        pch <- rep(pch[2:length(pch)], length.out=max.enc)
        p.pch <- pch[coords$seq]
      }
    } else if( length(pch) == 2 ){
      p.pch <- rep(pch[2], length.out=length(coords$seq))
      p.pch[coords$seq==1] <- pch[1]
    } else
      p.pch <- rep(pch, length.out=length(coords$seq))
    plot(coords$geometry, pch=p.pch, col=p.cols, cex=cex, add=TRUE)  
  }
  
  # now plot lines
  if( lwd > 0 )
    plot(sf$geometry, lwd=lwd[1], col=line.col[1], add=TRUE)
  
  invisible(sf)
  
} 
