extends Node

var minX = 800
var minY = 600

onready var vp1 = $vpc1/vp1
onready var vp2 = $"gui/minimap/vpc2/vp2"
onready var main_camera = $vpc1/vp1/main_camera
onready var map_camera = $"gui/minimap/vpc2/vp2/map_camera"
onready var world = $vpc1/vp1/map
onready var music = $music

var fullscreen = false
export (bool) var mute = false

func _ready():
	if mute:
		music.volume_db = -80
	vp2.world_2d = vp1.world_2d
	pass

func _input(event):
	
	if event.is_action_pressed("fullscreen"):
		fullscreen = !fullscreen
		OS.set_window_fullscreen(fullscreen)
		return
	if event.is_action_pressed("mute"):
		if !mute:
			music.volume_db = -80
			mute = !mute
		else:
			music.volume_db = 0
			mute = !mute
		return
	if event.is_action_pressed("exit"):
		get_tree().quit()