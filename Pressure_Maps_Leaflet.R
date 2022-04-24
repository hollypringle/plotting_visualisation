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

qpal <- colorQuantile("OrRd", covs_livestockrates$cattle_5min_event_rate, n = 5)



# !formatR
library(leaflet)

# an automatic legend derived from the color palette
pal <- colorNumeric("OrRd", df$z)
leaflet(df) %>%
  addTiles() %>%
  addCircleMarkers(~x, ~y, color = ~pal(z), group = "circles") %>%
  addLegend(pal = pal, values = ~z, group = "circles", position = "bottomleft") %>%
  addLayersControl(overlayGroups = c("circles"))

# format legend labels
df <- data.frame(x = rnorm(100), y = rexp(100, 2), z = runif(100))
pal <- colorBin("PuOr", df$z, bins = c(0, .1, .4, .9, 1))
leaflet(df) %>%
  addTiles() %>%
  addCircleMarkers(~x, ~y, color = ~pal(z), group = "circles") %>%
  addLegend(pal = pal, values = ~z, group = "circles", position = "bottomleft") %>%
  addLayersControl(overlayGroups = c("circles"))

leaflet(df) %>%
  addTiles() %>%
  addCircleMarkers(~x, ~y, color = ~pal(z), group = "circles") %>%
  addLegend(pal = pal, values = ~z, labFormat = labelFormat(
    prefix = "(", suffix = ")%", between = ", ",
    transform = function(x) 100 * x
  ),  group = "circles", position = "bottomleft" ) %>%
  addLayersControl(overlayGroups = c("circles"))


# creating a heat map for shoat
viz_map_shoat <- covs_livestockrates %>%
  leaflet() %>% 
  addTiles() %>% 
  addProviderTiles(providers$OpenStreetMap) %>% 
  setView(long_center,lat_center,6) %>%
  addHeatmap(lng=~longitude,lat=~latitude,intensity=~shoat_5min_event_rate,max=100,radius=25,blur=20)


# plot into a 1x2 grid; for that use the "mapview" package in R
install.packages("mapview")
library(mapview)
latticeview(viz_map_shoat, viz_map_cattle)
