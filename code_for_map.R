library(leaflet)
library(mapview)
library(htmltools)
library(dplyr)


#codes use: 1-currentwork, 2-pastwork, 3-training, 4-personnal, 5-conferences, 6-systems I studied
my.loc <- as.data.frame(rbind(c(5.447427, 43.529742, 4, "My hometown"), #Aix-en-Provence
                              c(6.2333, 44.1, 3, "'IUT' Environmental Biology 2009-11"), #Digne
                              c(-3.188267, 55.953252, 3, "Bachelor in Environmental Science 2011-12"), #Edinburgh
                               c(-1.514699, 43.481402, 3, "Master in Aquatic Ecology 2012-14"), #Anglet
                               c(5.8667, 45.65, 2, "Research Associate 2018"), #Bourget-du-lac 
                               c(5.917781, 45.564601, 3, "PhD student 2014-18"), #Chambéry USMB
                               c(6.477635, 46.373565, 2, "PhD student 2014-18"), #Thonon
                               c(8.555371, 45.928306, 2, "7 months in 2016 during PhD"), #Verbania
                               c(-73.212072, 44.475882, 2, "postdoc 2018-2021"), #Burlington
                              c(2.3488, 48.8534, 1, "postdoc 2021-current"), #Burlington
                               #conferences
                              c(18.063240,59.334591,5, "NETLAKE workshop 2014"), #Erken - Stockholm coordinates
                              c(6.60793,46.40111, 5, "Summer school in limnology 2014"), #Evian Summer school
                              c(5.447427, 43.529742, 5, "Rencontres Lacs Sentinelles 2014"), #Aix-en-Provence
                              c(6.143158,46.204391,5, "SEFS9 2015"), #Geneva CH
                              c(6.58793,46.40111, 5, "NETLAKE meeting 2015"), #Evian Summer school
                              c(105.071858, 51.903210, 5, "Summer school in limnology 2015"), #Bolshiye Koty,
                              c(5.917781, 45.564601, 5, "Meeting AFS 2015"), #Chambéry
                              c(11.30427, 46.01217, 5, "Cladoceran subfossils workshop 2016"), #Levico Terme IT
                              c(-0.87734,41.65606 ,5, "PAGES 2017"), #Zaragoza ES
                              c(17.25175, 49.59552, 5, "SEFS10 2017"), #Olomouc CZ
                              c(-111.876183, 40.758701, 5, "PAGES Ecore3 workshop 2018"), #Salt Lake City, UT
                              c(115.8614,-31.95224, 5, "AEMON-J workshop 2018"), #Perth WA
                              c(115.517,-32.002,5, "GLEON20 All hands' meeting 2018"), #Rottnest Island WA
                              c(-73.92097, 41.70037 , 5, "NYNEDAFS 2019"), #Poughkeepsie
                              #c(-77.9391797,43.2136713,5, "IAGLR 2019"), #Brockport NY
                              c(-82.639999,27.773056,5, "Ecopath 35 2019"), #St Petersburg FL
                              c(-73.9820,44.2796,5, "NYAFS 2020"), #Lake Placid, NY
                              c(-73.212072, 44.475882,5, "GLEON 21.5 2020"), #Remote, putting Burlington
                              c(-73.212072, 44.475882,5, "Aquacosm 2021"), #Remote, putting Burlington
                              c(-6.266155,53.350140,5, "SEFS12 2021"), #Remote,Dublin
                              #mylakes
                              c(-1.16667, 44.65, 6, "Master thesis Year 1"),#Bassin d'Arcachon
                              c(6.7916635,45.98832938 ,6, "Master thesis Year 2"),#Lac d'Anterne
                              c(6.0975, 44.9505556,6, "Master thesis Year 2"),#Lac de la Muzelle
                              c(6.16442,45.86858,6, "PhD thesis work"),#LakeAnnecy
                              c(5.86257,45.73662,6, "PhD thesis work"),#LakeBourget
                              c(6.51742,46.44267,6, "PhD thesis work"),#LakeGeneva
                              c(5.53530,45.45492,6, "PhD thesis work"),#LakeAiguebelette
                              #c(9.266111,45.994444,5),#LakeComo
                              c(8.5825,45.905,6, "PhD thesis work"),#LakeMaggiore
                              c(10.725,45.981944,6, "PhD thesis work"),#LakeLedro
                              c(10.625,45.555278,6, "PhD thesis work"),#LakeGarda
                              c(8.96,45.981944,6, "PhD thesis work"),#LakeLugano
                              c(8.733333,45.816667,6, "PhD thesis work"),#LakeVarese
                              c(6.285833,46.639444,6, "PhD thesis work"),#LakeJoux (de)
                              c(8.6833306, 47.249999 ,6, "PhD thesis work"),#Lake Zurich
                              c(6.90249639, 45.45916483, 6, "Research associate work"),#Lac de Tignes
                              c(-73.333332, 44.5333312, 6, "postdoc work"),#Lake Champlain
                              c(2.670633, 48.283761, 6, "postdoc work")#CEREEP Ecotron
 )
)
colnames(my.loc) <- c("lat","long","code","description")

# create the categories
my.loc <- mutate(my.loc, group = cut(as.numeric(code), breaks = c(0, 1,2,3,4,5, Inf), labels = c("currentwork", "work", "education", "personnal", "conferences", "mysystems")))
my.loc$lat <- as.numeric(paste(my.loc$lat))
my.loc$long <- as.numeric(paste(my.loc$long))

# create separate dataframes
for (i in unique(my.loc$code)) {
  nam <- paste("my.loc", i, sep = ".")
  assign(nam, my.loc[my.loc$code==i,])
}

#the html file
my.loc.html <- as.data.frame(rbind(c(5.447427, 43.529743, "<b><a href='images/map/Beaurecueil.JPG' target='_blank'>Sainte Victoire</a></b><br/>Beaurecueil, France"),
                                   c(-1.514699, 43.481402,"<b><a href='images/map/anglet.jpg' target='_blank'>Plage de la Marinella</a></b><br/>Anglet, France"),
                                   c(7.641618, 45.980537,"<b><a href='images/map/zermatt.jpg' target='_blank'>Matterhorn</a></b><br/>Zermatt, Switzerland"),
                                   c(-72.928829618, 44.159832694,"<b><a href='images/map/mount_ellen.JPG' target='_blank'>Mount Ellen</a></b><br/>Green Mountains, VT"),
                                   c(-112.9513500, 37.2594333,"<b><a href='images/map/angelslanding.JPG' target='_blank'>Angel's landing</a></b><br/>Zion National Park, UT"),
                                   c(6.701810,46.3385, "<b><a href='images/map/tetedesfieux.jpg' target='_blank'>Tête des fieux</a></b><br/>Chablais, France"),
                                   c(115.517,-32.002,"<b><a href='images/map/smokingceremony.JPG' target='_blank'>Smoking ceremony</a></b><br/>Rottnest Island, WA")
                                    
                                   ))
colnames(my.loc.html) <- c("lat","long","description")
my.loc.html$lat <- as.numeric(paste(my.loc.html$lat))
my.loc.html$long <- as.numeric(paste(my.loc.html$long))

### I downloaded markers from Google Images
### https://raw.githubusercontent.com/lvoogdt/Leaflet.awesome-markers/master/dist/images/markers-soft.png
myIcons <- iconList(currentwork = makeIcon(paste0(getwd(),"/images/icons/point_blue.png"), iconWidth = 12, iconHeight =12),
                    work = makeIcon(paste0(getwd(),"/images/icons/point.png"), iconWidth = 12, iconHeight =12), 
                    #work = makeIcon(paste0(getwd(),"/images/icons/work.png"), iconWidth = 12, iconHeight =12),
                    education = makeIcon(paste0(getwd(),"/images/icons/education.png"), iconWidth = 12, iconHeight =12),
                    personnal = makeIcon(paste0(getwd(),"/images/icons/home.png"), iconWidth = 12, iconHeight =12),
                    conferences = makeIcon(paste0(getwd(),"/images/icons/conference.png"), iconWidth = 12, iconHeight =12),
                    mysystems = makeIcon(paste0(getwd(),"/images/icons/cross.png"), iconWidth = 12, iconHeight =12)
                    #mysystems = makeIcon(paste0(getwd(),"/images/icons/waves.png"), iconWidth = 12, iconHeight =12)
                    )


# Pop up markers ####

# Map #####
mymap <-
  leaflet() %>% addTiles() %>% 
  addMarkers(my.loc.1$lat, my.loc.1$long,
             #clusterOptions = markerClusterOptions(),
             group="Current workplace", icon = myIcons[my.loc.1$group],
             popup = htmlEscape(my.loc.1$description)
  ) %>% 
  addMarkers(my.loc.2$lat, my.loc.2$long,
             #clusterOptions = markerClusterOptions(),
             group="Past workplaces", icon = myIcons[my.loc.2$group],
             popup = htmlEscape(my.loc.2$description)
  ) %>%
  addMarkers(my.loc.3$lat, my.loc.3$long,
             group="Education",icon = myIcons[my.loc.3$group],
             popup = htmlEscape(my.loc.3$description)
  ) %>%
  addMarkers(my.loc.4$lat, my.loc.4$long,
             group="Personnal",icon = myIcons[my.loc.4$group],
             popup = htmlEscape(my.loc.4$description)
  ) %>%
  addMarkers(my.loc.5$lat, my.loc.5$long,
             group="Conferences and workshops",icon = myIcons[my.loc.5$group],
             popup = htmlEscape(my.loc.5$description)
  ) %>%
  addMarkers(my.loc.6$lat, my.loc.6$long,
             group="Systems I study/studied", clusterOptions = markerClusterOptions(), icon = myIcons[my.loc.6$group],
             popup = htmlEscape(my.loc.6$description)
  ) %>%
  #to add multimedia
  addPopups(my.loc.html$lat, my.loc.html$long, my.loc.html$description,options = popupOptions(closeButton = FALSE ), group="photos!"
  ) %>%                   
  # Base groups
  addTiles(group = "OSM (default)") %>%
  addProviderTiles(providers$Stamen.Toner, group = "Toner") %>%
  addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") %>%
  # Overlay groups
  # addCircles(~long, ~lat, 300, stroke = F, group = "code", color = getColor() ) %>%
  # addPolygons(data = outline, lng = ~long, lat = ~lat,
  #             fill = F, weight = 2, color = "#FFFFCC", group = "Outline") %>%
  # Layers control
  addLayersControl(
    baseGroups = c("Toner Lite", "Toner", "OSM"),
    overlayGroups = c("Current workplace", "Past workplaces", "Personnal", "Conferences and workshops","Systems I study/studied", "photos!"),
    options = layersControlOptions(collapsed = FALSE),
    position = "bottomright"
  )  %>% 
  hideGroup(c("Personnal", "Past workplaces", "Education", "Conferences and workshops","Systems I study/studied", "photos!"))
   
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
#     baseGroups = c("Toner Lite", "OSM (default)", "Toner"),
#     overlayGroups = c("Quakes", "Outline"),
#     options = layersControlOptions(collapsed = FALSE)
#   )
# map
