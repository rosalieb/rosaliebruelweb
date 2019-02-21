library(leaflet)
library(mapview)
library(htmltools)

#codes use: 1-work, 2-training, 3-personnal, 4-conferences
my.loc <- as.data.frame(rbind(c(5.447427, 43.529742, 3), #Aix-en-Provence
                              c(6.2333, 44.1, 2), #Digne
                              c(-3.188267, 55.953252, 2), #Edinburgh
                              c(-1.514699, 43.481402, 2), #Anglet
                              c(5.8667, 45.65, 1), #Bourget-du-lac 
                              c(6.477635, 46.373565, 1), #Thonon
                              c(8.555371, 45.928306, 1), #Verbania
                              c(-73.212072, 44.475882, 1), #Burlington
                              #conferences
                              c(18.063240,59.334591,4), #Erken - Stockholm coordinates
                              c(6.58793,46.40111, 4), #Evian Summer school
                              c(6.143158,46.204391,4), #Geneva CH
                              c(105.071858, 51.903210, 4), #Bolshiye Koty,
                              c(45.564601, 5.917781, 4), #Chambéry
                              c(11.30427, 46.01217, 4), #Levico Terme IT
                              c(-0.87734,41.65606 ,4), #Zaragoza ES
                              c(17.25175, 49.59552, 4), #Olomouc CZ
                              c(-111.876183, 40.758701, 4), #Salt Lake City, UT
                              c(115.8614,-31.95224, 4), #Perth WA
                              c(115.517,-32.002,4), #Rottnest Island WA
                              c(-73.92097, 41.70037 , 4), #Poughkeepsie
                              c(-77.9391797,43.2136713,4) #Brockport NY
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

# Pop up markers ####

# Map #####
mymap <-
  # leaflet() %>%
  #   leaflet(my.loc) %>% addTiles() %>%
  #   addAwesomeMarkers(my.loc$lat, my.loc$long, icon=icons, label=as.character(my.loc$code))
  leaflet(my.loc) %>% addTiles() %>% addMarkers(~lat, ~long,
                                                clusterOptions = markerClusterOptions(),
                                                popup = ~as.character(htmlEscape(code))
                                                ) %>%
  # # Base groups
  # addTiles(group = "OSM (default)") %>%
  # addProviderTiles(providers$Stamen.Toner, group = "Toner") %>%
  # addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") %>%
  # Overlay groups
  addCircles(~long, ~lat, ~code, stroke = F, group = "code") %>%
  # addPolygons(data = outline, lng = ~long, lat = ~lat,
  #             fill = F, weight = 2, color = "#FFFFCC", group = "Outline") %>%
  # Layers control
  addLayersControl(
    baseGroups = c("OSM (default)", "code"),
    #overlayGroups = c("Quakes", "Outline"),
    options = layersControlOptions(collapsed = FALSE)
  )
   
mymap

# legend


#m <- mapview(breweries)

## create standalone .html
mapshot(mymap, url = paste0(getwd(), "/map.html"))



# outline <- quakes[chull(quakes$long, quakes$lat),]
# 
# map <- leaflet(quakes) %>%
#   # Base groups
#   addTiles(group = "OSM (default)") %>%
#   addProviderTiles(providers$Stamen.Toner, group = "Toner") %>%
#   addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") %>%
#   # Overlay groups
#   addCircles(~long, ~lat, ~10^mag/5, stroke = F, group = "Quakes") %>%
#   addPolygons(data = outline, lng = ~long, lat = ~lat,
#               fill = F, weight = 2, color = "#FFFFCC", group = "Outline") %>%
#   # Layers control
#   addLayersControl(
#     baseGroups = c("OSM (default)", "Toner", "Toner Lite"),
#     overlayGroups = c("Quakes", "Outline"),
#     options = layersControlOptions(collapsed = FALSE)
#   )
# map
