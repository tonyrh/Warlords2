extends Node2D

onready var main_camera = get_tree().get_root().get_node("main/vpc1/vp1/main_camera")

var ratio_map_minimap = 15.4 # TODO: must be calculated instead (width of map divided by width of miniamp)
var zoom = 0
export(Color, RGBA) var color = Color(1,1,1,.8) # Color is RGB.
export var width = 2.0

func _ready():
	# When the game window is resized we update the mini-map reticule
	# get_tree().get_root().connect("size_changed", self, "update")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _draw():
	_draw_reticule()
	pass

func _draw_reticule():
	# Camera zoom may change 
	zoom = ratio_map_minimap / main_camera.zoom.x
	# print("zoom: " + String(zoom))
	var tl = main_camera.position/ratio_map_minimap
	var tr = Vector2(main_camera.position.x/ratio_map_minimap + get_viewport().size.x/zoom, main_camera.position.y/ratio_map_minimap)
	draw_line(tl, tr, color, width)
	var br = Vector2(main_camera.position.x/ratio_map_minimap + get_viewport().size.x/zoom, main_camera.position.y/ratio_map_minimap + get_viewport().size.y/zoom)
	draw_line(tr, br, color, width)
	var bl = Vector2(main_camera.position.x/ratio_map_minimap, main_camera.position.y/ratio_map_minimap + get_viewport().size.y/zoom)
	draw_line(br, bl, color, width)
	draw_line(tl, bl, color, width)
	pass

