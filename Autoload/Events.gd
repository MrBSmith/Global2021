extends Node

# warnings-disable

#### PATHFINDER ####

signal query_path(who, from, to)
signal send_path(who, path)


#### INTERACTIONS ####

signal interact()
signal light_activated(light_source ,active)
signal damage_tile(cell)
signal gold_collected()

#### FOG ####

signal visible_tiles_update()

#### PROGRESSION ####

signal gold_amount_changed(amount)
