library(leaflet)
library(mapview)


#codes use: 1-work, 2-training, 3-personnal
my.loc <- as.data.frame(rbind(c(5.447427, 43.529742, 3), #Aix-en-Provence
                              c(5.8667, 45.65, 1), #Bourget-du-lac 
                              c(6.477635, 46.373565, 1), #Thonon
                              c(8.555371, 45.928306, 1), #Verbania
                              c(-73.212072, 44.475882, 1) #Burlington
)
)
colnames(my.loc) <- c("lat","long","code")

getColor <- function(my.loc) {
  sapply(my.loc$code, function(code) {
    if(code == 1) {
      "green"
    } else if(code == 2) {
      "orange"
    } else {
      "red"
    } })
}

# icons <- awesomeIcons(
#   icon = 'ios-close',
#   iconColor = 'black',
#   library = 'ion',
#   markerColor = getColor(my.loc)
# )



mymap <-
  # leaflet() %>%
  #   leaflet(my.loc) %>% addTiles() %>%
  #   addAwesomeMarkers(my.loc$lat, my.loc$long, icon=icons, label=as.character(my.loc$code))
  leaflet(my.loc) %>% addTiles() %>% addMarkers(my.loc$lat, my.loc$long,
                                                clusterOptions = markerClusterOptions())


#m <- mapview(breweries)

## create standalone .html
mapshot(mymap, url = paste0(getwd(), "/map.html"))
