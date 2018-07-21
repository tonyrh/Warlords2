extends CanvasLayer

enum STATES { HIDDEN, SHOWN }
var _state = SHOWN

onready var minimap = $minimap

func _ready():
	minimap.show()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _change_state(new_state):
	if new_state == HIDDEN:
		get_tree().call_group("minimap", "hide")
		$"top/close_button".texture_normal = load("res://gui/assets/maximize.png")
	if new_state == SHOWN:
		get_tree().call_group("minimap", "show")
		$"top/close_button".texture_normal = load("res://gui/assets/close.png")
	_state = new_state

func _on_close_button_pressed():
	if _state == SHOWN:
		_change_state(HIDDEN)
	elif _state == HIDDEN:
		_change_state(SHOWN)

func _on_close_button_mouse_entered():
	Input.set_custom_mouse_cursor(load("res://gui/assets/finger.png"))
	pass

func _on_close_button_mouse_exited():
	Input.set_custom_mouse_cursor(load("res://gui/assets/cursor.png"))
	pass
