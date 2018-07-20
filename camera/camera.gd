extends Camera2D

# Move camera by keys on/off
export (bool) var panning = true

# Camera speed in px/s.
export (int) var camera_speed = 450 

export (float) var max_zoom = 0.5

# Initial zoom value taken from Editor.
var camera_zoom = get_zoom()

# It changes a camera zoom value in units... (?, but it works... it probably
## multiplies camera size by 1+camera_zoom_speed)
const camera_zoom_speed = Vector2(0.5, 0.5)

# Vector of camera's movement / second.
var camera_movement = Vector2()

# Previous mouse position used to count delta of the mouse movement.
var _prev_mouse_pos = null

## Move camera by keys: left, top, right, bottom.
var __keys = [false, false, false, false]

var camera_limit_left = 0
var camera_limit_right = 0
var camera_limit_top = 0
var camera_limit_bottom = 0

var zoom_limit = Vector2(1,1)

func _ready():
	_set_camera_limits()
	_set_zoom_limits()
	
	set_h_drag_enabled(false)
	set_v_drag_enabled(false)
	set_enable_follow_smoothing(true)
	set_follow_smoothing(4)
	set_physics_process(true)
	set_process_unhandled_input(true)
	
	set_process_input(true)
	
	get_tree().get_root().connect("size_changed", self, "update")
	print("zoom: " + String(zoom))

func _input(ev):
	
	# print("camera position: " + String(position))
		
	if ev.is_action_pressed("zoom_in") and zoom.x > zoom_limit.y:
		zoom = Vector2(zoom.x - 0.25, zoom.y - 0.25)
		print("zoom in: " + String(zoom))
		update()
		return
	elif ev.is_action_pressed("zoom_out") and zoom.x < zoom_limit.x:
		zoom = Vector2(zoom.x + 0.25, zoom.y + 0.25)
		print("zoom out: " + String(zoom))
		update()
		return
	

	# Control by keyboard handled by InpuMap.
	if ev.is_action_pressed("ui_left"):
		__keys[0] = true
	if ev.is_action_pressed("ui_up"):
		__keys[1] = true
	if ev.is_action_pressed("ui_right"):
		__keys[2] = true
	if ev.is_action_pressed("ui_down"):
		__keys[3] = true
	if ev.is_action_released("ui_left"):
		__keys[0] = false
	if ev.is_action_released("ui_up"):
		__keys[1] = false
	if ev.is_action_released("ui_right"):
		__keys[2] = false
	if ev.is_action_released("ui_down"):
		__keys[3] = false

	pass

func update():
	# Called when zoom changes, the game window is resized, or the camera position changes
	
	# Update camera limits
	_set_camera_limits()
	
	# Update camera zoom
	_set_zoom_limits()
	
	# Fix zoom if too small (can happen after a window resize... I think):
	if zoom.x > zoom_limit.x:
		zoom = Vector2(zoom_limit.x, zoom_limit.x)
	if zoom.x < zoom_limit.y:
		zoom = Vector2(zoom_limit.y, zoom_limit.y)

	# Fix camera position if out of bounds
	if !_inside_camera_limits(position):
		_bind_camera_to_limits()

			
	# Send signal to minimap so it can redraw the reticule etc...
	get_tree().call_group("minimap", "update")
		
func _physics_process(delta):
	# Move camera by keys defined in InputMap (ui_left/top/right/bottom).
	if panning:
		if __keys[0]:
			camera_movement.x -= camera_speed * delta
		if __keys[1]:
			camera_movement.y -= camera_speed * delta
		if __keys[2]:
			camera_movement.x += camera_speed * delta
		if __keys[3]:
			camera_movement.y += camera_speed * delta

	# Update position of the camera only if that position is inside camera limits
	var new_position = position + camera_movement * get_zoom()
	if _inside_camera_limits(new_position):
		position = new_position
		get_tree().call_group("minimap", "update")
		update()

	# Set camera movement to zero, update old mouse position.
	camera_movement = Vector2(0,0)
	_prev_mouse_pos = get_viewport().get_mouse_position()

func _inside_camera_limits(pos):
	if pos.x >= camera_limit_left and pos.x <= camera_limit_right and pos.y >= camera_limit_top and pos.y <= camera_limit_bottom: 
		return true
	# print("camera limit hit: " + String(pos))
	return false

func _set_camera_limits():
	# print("window size: " + String( get_node("/root").size.x) + " " + String( get_node("/root").size.y))
	var map = get_node("../map/lvl0")
	var map_limits = map.get_used_rect()
	var map_cellsize = map.cell_size
	camera_limit_left = map_limits.position.x * map_cellsize.x 
	camera_limit_right = ( map_limits.end.x * map_cellsize.x ) - get_node("/root").size.x * zoom.x
	camera_limit_top = map_limits.position.y * map_cellsize.y 
	camera_limit_bottom = ( map_limits.end.y * map_cellsize.y ) - get_node("/root").size.y * zoom.y

func _set_zoom_limits():
	var map = get_node("../map/lvl0")
	var map_limits = map.get_used_rect()
	var map_cellsize = map.cell_size
	# var max_zoom = ( get_node("/root").size.x * zoom.x ) / ( map_limits.end.x * map_cellsize.x )
	# var max_zoom = 0.5
	var min_zoom = ( map_limits.end.x * map_cellsize.x ) / ( get_node("/root").size.x * zoom.x )
	zoom_limit = Vector2(min_zoom, max_zoom)
	# print("zoom limit min: " + String(min_zoom) + " max: " + String(max_zoom))
	pass

func _bind_camera_to_limits():
	# add 
	if position.x > camera_limit_right:
		position.x = camera_limit_right
	if position.y > camera_limit_bottom:
		position.y = camera_limit_bottom
	pass

func move_to(pos):
	print("move to: " + String(pos))
	position = pos[0]
	update()
	pass