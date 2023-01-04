add.geometry <- 
function(df, na.rm=TRUE){
  
  ## first remove any missing coordinates
  if( na.rm ){
    missing <- apply(df, 1, function(x) anyNA(x[c('lon', 'lat')]))
    sum.miss <- sum(missing)
    if( sum.miss > 0 ){
      df <- df[!missing, ]
      warning(paste(sum.miss, ifelse(sum.miss==1,"value","values"), "with missing coordinates deleted"), call.=FALSE)
    }
  }
  # check they are in the right order
  df <- df[order(df$ring, df$year, df$month, df$day), ]
  df$id <- as.numeric(as.factor(df$ring))
  
  sf <- sfheaders::sf_linestring(df, x="lon", y="lat", linestring_id="id")
  sf <- merge(sf, df, by="id", all.y=TRUE)
  st_crs(sf) <- "EPSG:4326"  # WGS84
  sf$id <- NULL
  
  return(sf)
  
}