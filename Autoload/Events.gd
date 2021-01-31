extends Node

# warnings-disable

signal gameover()
signal win()

#### PATHFINDER ####

signal query_path(who, from, to)
signal send_path(who, path)


#### INTERACTIONS ####

signal interact()
signal light_activated(light_source, active)
signal body_entered_light(light_source, body)
signal body_exited_light(light_source, body)
signal damage_tile(cell)
signal gold_collected()

#### FOG ####

signal visible_tiles_update()

#### PROGRESSION ####

signal gold_amount_changed(amount)
