extends Control

var ratio_map_minimap = 15.4 # TODO: must be calculated instead (width of map divided by width of miniamp)

onready var main_camera = get_tree().get_root().get_node("main/vpc1/vp1/main_camera")
onready var map = get_tree().get_root().get_node("main/vpc1/vp1/map/lvl0")
onready var rect = Rect2( Vector2(0,0), rect_size )
onready var map_limits = map.get_used_rect()
onready var map_cellsize = map.cell_size
onready var map_size = map_limits.size * map_cellsize
onready var ratio = ( map_size / rect_size )

# onready var origin = $minimap_reticule

var zoom = 0

export(Color, RGBA) var color = Color(1,1,1,.8) # Color is RGB.
export var width = 2.0

func _ready():
	get_tree().get_root().connect("size_changed", self, "update")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _input(event):
	if event.is_action_pressed("left_mouse"):
		if rect.has_point(get_local_mouse_position()):
			get_tree().call_group("main_camera", "move_to", [get_local_mouse_position() * ratio])
	pass

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