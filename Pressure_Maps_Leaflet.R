# importing leaflet and leaflet.extras will enable me to make a heatmap
library(leaflet)
library(leaflet.extras)
library(magrittr)

# define center of map
head(covs_livestockrates)
lat_center <- c(covs_livestockrates$latitude) %>% as.numeric() %>% mean
long_center <- mean(c(covs_livestockrates$longitude) )

library(RColorBrewer)
install.packages("leaflegend")
library(leaflegend)
# creating a heat map for cattle
# adding color schemes to crime types
numericPal <- colorNumeric("YlOrRd", covs_livestockrates$cattle_5min_event_rate)
viz_map_cattle <- covs_livestockrates %>%
  leaflet() %>% 
  addTiles() %>% 
  addProviderTiles(providers$OpenStreetMap) %>% 
  setView(long_center,lat_center,6) %>%
  addHeatmap(lng=~longitude,lat=~latitude,intensity=~cattle_5min_event_rate,max=100,radius=30,blur=50, gradient="YlOrRd")%>% 
  addLegendNumeric(pal=numericPal,title = 'Cattle Trap Rate', 
                   values = covs_livestockrates$cattle_5min_event_rate,
                   position = 'bottomright',
                   orientation = 'horizontal',
                   width = 250,
                   height = 40,)

numericPal <- colorNumeric("YlOrRd", covs_livestockrates$shoat_5min_event_rate)
viz_map_shoat <- covs_livestockrates %>%
  leaflet() %>% 
  addTiles() %>% 
  addProviderTiles(providers$OpenStreetMap) %>% 
  setView(long_center,lat_center,6) %>%
  addHeatmap(lng=~longitude,lat=~latitude,intensity=~shoat_5min_event_rate,max=100,radius=30,blur=50, gradient="YlOrRd")%>% 
  addLegendNumeric(pal=numericPal,title = 'Shoat Trap Rate', 
                   values = covs_livestockrates$shoat_5min_event_rate,
                   position = 'bottomright',
                   orientation = 'horizontal',
                   width = 250,
                   height = 40,)

# plot into a 1x2 grid; for that use the "mapview" package in R
install.packages("mapview")
library(mapview)
latticeview(viz_map_shoat, viz_map_cattle)
