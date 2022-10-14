###################################################################################
# Computes decimal coordinates from degrees and minutes
# x: vector containing degrees and minutes
# Author: Fraenzi Korner, 9.9.2004, www.oikostat.ch and www.vogelwarte.ch
#         updated 14.10.2022 to include seconds
###################################################################################
decimal.coord<-function(x){
  # x is a numeric vector of the following format dd.mmss, e.g. 55.3215 for 55degree 32' 15''
  t.sign<-sign(x)
  t.min <-floor(100*(abs(x)-abs(trunc(x))))/100
  t.sec <- abs(100*x)-abs(trunc(100*x))
  t.dec1 <- t.min*(5/3)
  t.dec2 <- t.sec*(5/3)
  t.decimals <- t.dec1 + t.dec2/100
  t.dec<-t.sign*(abs(trunc(x))+t.decimals)
  t.dec
}
###################################################################################