library(osmdata)
library(sf)

# OSM query
# ESSA with bboxfinder
bb_lonlat <- c(17.894385,59.621528,17.993777,59.672014)
# EGKK bb_lonlat <- c(-0.223915,51.141733,-0.155851,51.165738)
apt_icao  <- "ESSA"
apt_name  <- "Stockholm Arlanda"

q <- opq(bbox = bb_lonlat) %>%
  add_osm_feature(
    key = "aeroway"
    ,value =c("aerodrome", "apron", "control_tower", "gate", "hangar"
              ,"helipad", "runway", "taxiway", "terminal") ) %>%
  osmdata_sf() %>%
  unique_osmdata()

g <- ggplot() +
  geom_sf(data = q$osm_polygons
          ,inherit.aes = FALSE
          ,color = "lightblue"
          #,fill  = "lightblue"
  ) +
  geom_sf(data = q$osm_lines %>% filter(aeroway != "runway")
          , color = "grey"
  ) +
  geom_sf(data = q$osm_lines %>% filter(aeroway == "runway"),
          inherit.aes = FALSE,
          color = "black",
          size = 2 #.4
          ,alpha = .8) +
  theme_void() +
  labs(title = apt_icao)

g
