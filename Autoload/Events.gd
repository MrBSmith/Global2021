extends Node

# warnings-disable

#### PATHFINDER ####

signal query_path(who, from, to)
signal send_path(who, path)


#### INTERACTIONS ####

signal interact()
signal light_activated(light_source ,active)
signal damage_tile(cell)

#### FOG ####

signal visible_tiles_update()
