library(leaflet)
library(mapview)
library(htmltools)
library(dplyr)


#codes use: 1-work, 2-training, 3-personnal, 4-conferences, 5-systems I studied
my.loc <- as.data.frame(rbind(c(5.447427, 43.529742, 3, "My hometown"), #Aix-en-Provence
                              c(6.2333, 44.1, 2, "'IUT' Environmental Biology 2009-11"), #Digne
                              c(-3.188267, 55.953252, 2, "Bachelor in Environmental Science 2011-12"), #Edinburgh
                               c(-1.514699, 43.481402, 2, "Master in Aquatic Ecology 2012-14"), #Anglet
                               c(5.8667, 45.65, 1, "Research Associate 2018"), #Bourget-du-lac 
                               c(5.917781, 45.564601, 2, "PhD student 2014-18"), #Chambéry USMB
                               c(6.477635, 46.373565, 1, "PhD student 2014-18"), #Thonon
                               c(8.555371, 45.928306, 1, "7 months in 2016 during PhD"), #Verbania
                               c(-73.212072, 44.475882, 1, "postdoc 2018-current"), #Burlington
                               #conferences
                              c(18.063240,59.334591,4, "NETLAKE workshop 2014"), #Erken - Stockholm coordinates
                              c(6.60793,46.40111, 4, "Summer school in limnology 2014"), #Evian Summer school
                              c(5.447427, 43.529742, 4, "Rencontres Lacs Sentinelles 2014"), #Aix-en-Provence
                              c(6.143158,46.204391,4, "SEFS9 2015"), #Geneva CH
                              c(6.58793,46.40111, 4, "NETLAKE meeting 2015"), #Evian Summer school
                              c(105.071858, 51.903210, 4, "Summer school in limnology 2015"), #Bolshiye Koty,
                              c(5.917781, 45.564601, 4, "Meeting AFS 2015"), #Chambéry
                              c(11.30427, 46.01217, 4, "Cladoceran subfossils workshop 2016"), #Levico Terme IT
                              c(-0.87734,41.65606 ,4, "PAGES 2017"), #Zaragoza ES
                              c(17.25175, 49.59552, 4, "SEFS10 2017"), #Olomouc CZ
                              c(-111.876183, 40.758701, 4, "PAGES Ecore3 workshop 2018"), #Salt Lake City, UT
                              c(115.8614,-31.95224, 4, "AEMON-J workshop 2018"), #Perth WA
                              c(115.517,-32.002,4, "GLEON20 All hands' meeting 2018"), #Rottnest Island WA
                              c(-73.92097, 41.70037 , 4, "NYNEDAFS 2019"), #Poughkeepsie
                              c(-77.9391797,43.2136713,4, "IAGLR 2019"), #Brockport NY
                              #mylakes
                              c(-1.16667, 44.65, 5, "Master thesis Year 1"),#Bassin d'Arcachon
                              c(6.7916635,45.98832938 ,5, "Master thesis Year 2"),#Lac d'Anterne
                              c(6.0975, 44.9505556,5, "Master thesis Year 2"),#Lac de la Muzelle
                              c(6.16442,45.86858,5, "PhD thesis work"),#LakeAnnecy
                              c(5.86257,45.73662,5, "PhD thesis work"),#LakeBourget
                              c(6.51742,46.44267,5, "PhD thesis work"),#LakeGeneva
                              c(5.53530,45.45492,5, "PhD thesis work"),#LakeAiguebelette
                              #c(9.266111,45.994444,5),#LakeComo
                              c(8.5825,45.905,5, "PhD thesis work"),#LakeMaggiore
                              c(10.725,45.981944,5, "PhD thesis work"),#LakeLedro
                              c(10.625,45.555278,5, "PhD thesis work"),#LakeGarda
                              c(8.96,45.981944,5, "PhD thesis work"),#LakeLugano
                              c(8.733333,45.816667,5, "PhD thesis work"),#LakeVarese
                              c(6.285833,46.639444,5, "PhD thesis work"),#LakeJoux (de)
                              c(8.6833306, 47.249999 ,5, "PhD thesis work"),#Lake Zurich
                              c(6.90249639, 45.45916483, 5, "Research associate work"),#Lac de Tignes
                              c(-73.333332, 44.5333312, 5, "postdoc work")#Lake Champlain
 )
)
colnames(my.loc) <- c("lat","long","code","description")

# create the categories
my.loc <- mutate(my.loc, group = cut(as.numeric(code), breaks = c(0, 1,2,3,4, Inf), labels = c("work", "education", "personnal", "conferences", "mysystems")))
my.loc$lat <- as.numeric(paste(my.loc$lat))
my.loc$long <- as.numeric(paste(my.loc$long))

# create separate dataframes
for (i in unique(my.loc$code)) {
  nam <- paste("my.loc", i, sep = ".")
  assign(nam, my.loc[my.loc$code==i,])
}

#the html file
my.loc.html <- as.data.frame(rbind(c(5.447427, 43.529742, "<b><a href='images/map/Beaurecueil.JPG' target='_blank'>Sainte Victoire</a></b><br/>Beaurecueil, France"),
                                   c(-1.514699, 43.481402,"<b><a href='images/map/anglet.jpg' target='_blank'>Plage de la Marinella</a></b><br/>Anglet, France"),
                                   c(7.641618, 45.980537,"<b><a href='images/map/zermatt.jpg' target='_blank'>Matterhorn</a></b><br/>Zermatt, Switzerland"),
                                   c(-72.928829618, 44.159832694,"<b><a href='images/map/mount_ellen.JPG' target='_blank'>Mount Ellen</a></b><br/>Green Mountains, VT"),
                                   c(-112.9513500, 37.2594333,"<b><a href='images/map/angelslanding.JPG' target='_blank'>Angel's landing</a></b><br/>Zion National Park, UT"),
                                   c(6.701810,46.3384, "<b><a href='images/map/tetedesfieux.JPG' target='_blank'>Tête des fieux</a></b><br/>Chablais, France"),
                                   c(115.517,-32.002,"<b><a href='images/map/smokingceremony.JPG' target='_blank'>Smoking ceremony</a></b><br/>Rottnest Island, WA")
                                    
                                   ))
colnames(my.loc.html) <- c("lat","long","description")
my.loc.html$lat <- as.numeric(paste(my.loc.html$lat))
my.loc.html$long <- as.numeric(paste(my.loc.html$long))

### I downloaded markers from Google Images
### https://raw.githubusercontent.com/lvoogdt/Leaflet.awesome-markers/master/dist/images/markers-soft.png
myIcons <- iconList(work = makeIcon(paste0(getwd(),"/images/icons/work.png"), iconWidth = 24, iconHeight =24),
                    education = makeIcon(paste0(getwd(),"/images/icons/education.png"), iconWidth = 24, iconHeight =24),
                    personnal = makeIcon(paste0(getwd(),"/images/icons/home.png"), iconWidth = 24, iconHeight =24),
                    conferences = makeIcon(paste0(getwd(),"/images/icons/conference.png"), iconWidth = 24, iconHeight =24),
                    mysystems = makeIcon(paste0(getwd(),"/images/icons/waves.png"), iconWidth = 24, iconHeight =24)
                    )


# Pop up markers ####

# Map #####
mymap <-
  leaflet() %>% addTiles() %>% 
  addMarkers(my.loc.1$lat, my.loc.1$long,
             #clusterOptions = markerClusterOptions(),
             group="Workplaces",icon = myIcons[my.loc.1$group],
             popup = htmlEscape(my.loc.1$description)
  ) %>%
  addMarkers(my.loc.2$lat, my.loc.2$long,
             group="Education",icon = myIcons[my.loc.2$group],
             popup = htmlEscape(my.loc.2$description)
  ) %>%
  addMarkers(my.loc.3$lat, my.loc.3$long,
             group="Personnal",icon = myIcons[my.loc.3$group],
             popup = htmlEscape(my.loc.3$description)
  ) %>%
  addMarkers(my.loc.4$lat, my.loc.4$long,
             group="Conferences and workshops",icon = myIcons[my.loc.4$group],
             popup = htmlEscape(my.loc.4$description)
  ) %>%
  addMarkers(my.loc.5$lat, my.loc.5$long,
             group="Systems I study/studied",icon = myIcons[my.loc.5$group],
             popup = htmlEscape(my.loc.5$description)
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
    baseGroups = c("OSM (default)", "Toner", "Toner Lite"),
    overlayGroups = c("Workplaces", "Education","Personnal", "Conferences and workshops","Systems I study/studied", "photos!"),
    options = layersControlOptions(collapsed = FALSE),
    position = "bottomright"
  )  %>% hideGroup(c("Personnal", "Conferences and workshops","Systems I study/studied", "photos!"))
   
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
